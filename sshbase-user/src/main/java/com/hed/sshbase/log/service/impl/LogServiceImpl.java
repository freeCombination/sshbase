package com.hed.sshbase.log.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hed.sshbase.common.constant.SystemConstant;
import com.hed.sshbase.common.dao.IBaseDao;
import com.hed.sshbase.common.exception.BusinessException;
import com.hed.sshbase.common.util.DateUtil;
import com.hed.sshbase.common.vo.ListVo;
import com.hed.sshbase.dict.entity.Dictionary;
import com.hed.sshbase.dict.service.IDictService;
import com.hed.sshbase.log.entity.Log;
import com.hed.sshbase.log.service.ILogService;
import com.hed.sshbase.log.vo.LogVo;
import com.hed.sshbase.user.entity.User;
import com.opensymphony.xwork2.ActionContext;

/**
 * 详细实现日志接口定义的方法
 * 
 * @author wanglc
 * @version V1.20,2013-11-25 下午3:18:46
 * @see [相关类/方法]
 * @since V1.20
 * @depricated
 */
@SuppressWarnings({"unchecked", "rawtypes"})
@Service("logService")
public class LogServiceImpl implements ILogService {
    
    @Autowired
    @Qualifier("baseDao")
    private IBaseDao baseDao;
    
    public void setBaseDao(IBaseDao baseDao) {
        this.baseDao = baseDao;
    }
    
    /**
     * @Fields dictService : 字典相关处理工具类
     */
    @Autowired
    protected IDictService dictService;
    
    /**
     * 添加日志
     * 
     * @Title addLog
     * @author wanglc
     * @Description:
     * @date 2013-11-25
     * @param log 日志对象
     * @throws BusinessException
     */
    @Transactional(readOnly = false, propagation = Propagation.REQUIRES_NEW)
    @Override
    public void addLog(Log log)
        throws BusinessException {
    	 log.setOpDate(new Date());
    	 HttpServletRequest request=null;
    	 if (ActionContext.getContext() != null && ActionContext.getContext().get(ServletActionContext.HTTP_REQUEST) != null) {
    		 request = ServletActionContext.getRequest();
    		 log.setIpUrl(request.getRemoteAddr());
    	 }
    	 if(log.getUser()==null){
    		 if(request!=null){
    			 log.setUser( (User) request.getSession().getAttribute(SystemConstant.CURRENT_USER));
    		 }
         }
         
         //处理 只用dictCode 来新建日志类型
         if(log.getType()!=null &&( log.getType().getPkDictionaryId() == null || log.getType().getPkDictionaryId()==0 ) ){
        	 if(StringUtils.isNotBlank(log.getType().getDictCode())){
        		 Dictionary dict = dictService.getDictByCode(log.getType().getDictCode());
        		 if(dict!=null){
        			 log.setType(dict);
        		 }
        	 }
         }
        // 取得字典类型的uuid
        log.setLogTypeUUID(log.getType().getFkDictTypeUUID());
        // 执行保存
        this.baseDao.save(log);
    }
    
    /**
     * 查询日志
     * 
     * @Title getLogList
     * @author wanglc
     * @Description:
     * @date 2013-11-25
     * @param params 参数Map
     * @return ListVo<Log> 日志列表集合
     */
    @Override
    public ListVo<LogVo> getLogList(Map<String, String> params)
        throws BusinessException {
        // 获取页面参数
        String startTime = params.get("startDate");
        String endTime = params.get("endDate");
        String type = params.get("type");
        String typeDictCode = params.get("typeDictCode");
        String logContent = params.get("logContent");
        String opType = params.get("opType");
        String opVersion = params.get("opVersion");
        String srcTableName = params.get("srcTableName");
        String parentTableName = params.get("parentTableName");
        String srcId = params.get("srcId");
        String parentRecordId = params.get("parentRecordId");
        int start = NumberUtils.toInt(params.get("start"));
        int limit = NumberUtils.toInt(params.get("limit"));
        ListVo<LogVo> vo = new ListVo<LogVo>();
        List<LogVo> voList = new ArrayList<LogVo>();
        Map pram = new HashMap();
        // 新建查询HQL语句
        StringBuffer logHql;
        if(StringUtils.isNotBlank(srcTableName) && StringUtils.isNotBlank(srcId)){
        	logHql = new StringBuffer("select t from Log l, Log t  where l.opVersion=t.opVersion ");
        }else{
        	logHql = new StringBuffer("from Log l where 1=1 ");
        }
        if(StringUtils.isNotBlank(type)){
        	logHql.append("and l.type.pkDictionaryId =:type ");
             pram.put("type", Integer.parseInt(type));
        }
        
        if(StringUtils.isNotBlank(typeDictCode)){
        	logHql.append("and l.type.dictCode =:typeDictCode ");
             pram.put("typeDictCode", typeDictCode);
        }
       
        if(StringUtils.isNotBlank(typeDictCode)){
            if(StringUtils.isNotBlank(srcTableName) && StringUtils.isNotBlank(srcId)){
           	 logHql.append("and t.type.dictCode =:typeDictCode ");
                pram.put("typeDictCode", typeDictCode);
            }else{
           	 logHql.append("and l.type.dictCode =:typeDictCode ");
                pram.put("typeDictCode", typeDictCode);
            }
       }
        
        if(StringUtils.isNotBlank(opType)){
        	logHql.append(" and l.opType like :opType");
        	pram.put("opType", "%"+opType+"%");
        }
        
        if(StringUtils.isNotBlank(opVersion)){
        	logHql.append(" and l.opVersion = :opVersion");
        	pram.put("opVersion",opVersion);
        }
        
        if(StringUtils.isNotBlank(srcTableName)){
        	logHql.append(" and l.srcTableName = :srcTableName");
        	pram.put("srcTableName", srcTableName);
        }
        
        if(StringUtils.isNotBlank(parentTableName)){
        	logHql.append(" and l.parentTableName = :parentTableName");
        	pram.put("parentTableName", parentTableName);
        }
        
        if(StringUtils.isNotBlank(srcId)){
        	logHql.append(" and l.srcId = :srcId");
        	pram.put("srcId", srcId);
        }
        
        if(StringUtils.isNotBlank(parentRecordId)){
        	logHql.append(" and l.parentRecordId = :parentRecordId");
        	pram.put("parentRecordId", parentRecordId);
        }
        
        if(StringUtils.isNotBlank(startTime)){
        	pram.put("startTime", DateUtil.string2date(startTime));
        	logHql.append(StringUtils.isNotBlank(startTime) ? 
        	            " and l.opDate >= :startTime" : "");
        }
        if(StringUtils.isNotBlank(endTime)){
        	Date d = new Date(DateUtil.string2date(endTime).getTime()+24*60*60*1000);
        	pram.put("endTime", d);
        	logHql.append(StringUtils.isNotBlank(endTime) ? 
                    " and l.opDate<:endTime" : "");
        }
        
        if(StringUtils.isNotBlank(logContent)){
            logHql.append(" and l.opContent like :content");
            pram.put("content", "%" + logContent + "%");
        }
        
        // entity转换为vo
        try{
            // 查询总条数
            int totalCount = baseDao.queryTotalCount(logHql.toString(), pram);
            
            logHql.append(" order by l.opDate desc ");
            // queryEntitysByPage(start, limit, hql, new HashMap());
            // 分页查询
            List<Log> logList =
                (List<Log>)baseDao.findPageByQuery(start,
                    limit,
                    logHql.toString(),
                    pram);
            
            if (logList != null && logList.size() > 0) {
                for (Log l : logList) {
                    LogVo lv = new LogVo(l);
                    voList.add(lv);
                }
            }
            
            // 设置返回结果
            vo.setList(voList);
            vo.setTotalSize(totalCount);
        }
        catch(Exception e){
        	throw new BusinessException(e.getMessage(), e);
        }
        
        return vo;
    }
    
    /**
     * 删除日志
     * 
     * @Title delLog
     * @author wanglc
     * @Description:
     * @date 2013-11-25
     * @param params 参数Map
     * @return String 删除结果
     */
    @Transactional(readOnly = false, propagation = Propagation.REQUIRED)
    @Override
    public String delLog(Map<String, String> params)
        throws BusinessException {
        String ids = params.get("ids");
        if (ids == null || "".equals(ids)) {
            return "{success:'false',msg:'删除日志失败'}";
        }
        else {
            for (String logId : ids.split(",")) {
                baseDao.deleteEntityById(Log.class,
                    NumberUtils.toLong(logId));
            }
        }
        return "{success:'true',msg:'删除日志成功'}";
    }
    
    /**
     * 查询日志类型
     * 
     * @Title getLogType
     * @author ls
     * @Description:
     * @date 2014-2-24
     * @param params 字典code
     * @return List 字典数据集合
     */
    @Override
    public List<Dictionary> getLogType(Map<String, String> params)
        throws BusinessException {
        // 查询字典类型用以封装类型树
        return baseDao.queryEntitys(" from  Dictionary d  where d.dictionaryType.typeCode='"
            + params.get("code") + "'");
    }
}
