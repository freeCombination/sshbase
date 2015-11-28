package com.hed.sshbase.ds2.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hed.sshbase.common.dao.IBaseDao2;
import com.hed.sshbase.ds2.entity.User;
import com.hed.sshbase.ds2.service.IUserService;

/**
 * 用户接口实现类
 */
@Service("userService2")
public class UserServiceImpl implements IUserService {
    /**
     * 持久层接口
     */
    @Autowired
    @Qualifier("baseDao2")
    private IBaseDao2 baseDao2;
    
    public void setBaseDao2(IBaseDao2 baseDao2) {
        this.baseDao2 = baseDao2;
    }

	@Override
	public List<User> getAllUser() throws Exception {
		String hql = " from User";
		
		List<User> usrLst = (List<User>)baseDao2.queryEntitys(hql);
		System.out.println(usrLst.get(0).getUsername());
		
		return null;
	}

	@Override
	public void addUpdateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
