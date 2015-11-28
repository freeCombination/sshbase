package com.hed.sshbase.resource.vo;

import java.util.List;
/**
 * 组装菜单的VO
 * 
 * @author dong.he
 * @version V1.20,2014年9月29日 下午4:00:50
 * @see [相关类/方法]
 * @since V1.20
 * @depricated
 */
public class ResMenuVo {
    /**
     * 名称
     */
    private String name;
    
    /**
     * url地址
     */
    private String url;
    
    /**
     * url地址
     */
    private String href;
    
    /**
     * url地址
     */
    private String hrefTarget="frame_Content";
    
    /**
     * 是否为叶子
     */
    private boolean leaf;
    
    /**
     * id
     */
    private String id;
    
    /**
     * 文本
     */
    private String text;
    
    /**
     * 父节点ID
     */
    private String parentId;
    
    /**
     * 值
     */
    private String value;
    
    /**
     * 是否展开
     */
    private boolean expanded;
    
    /**
     * 下一级菜单
     */
    private List<ResMenuVo> children;
    
    /**
     * disOrder : 资源排序
     */
    private Integer disOrder;
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getUrl() {
        return url;
    }
    
    public void setUrl(String url) {
        this.url = url;
        this.href=url+"?id="+this.id;
    }
    
    public String getText() {
        return text;
    }
    
    public void setText(String text) {
        this.text = text;
    }
    
    public String getValue() {
        return value;
    }
    
    public void setValue(String value) {
        this.value = value;
    }
    
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getParentId() {
        return parentId;
    }
    
    public void setParentId(String parentId) {
        this.parentId = parentId;
    }
    
    public boolean isLeaf() {
        return leaf;
    }
    
    public void setLeaf(boolean leaf) {
        this.leaf = leaf;
    }
    
    public List<ResMenuVo> getChildren() {
        return children;
    }
    
    public void setChildren(List<ResMenuVo> cls) {
        this.children = cls;
    }

    public Integer getDisOrder() {
        return disOrder;
    }

    public void setDisOrder(Integer disOrder) {
        this.disOrder = disOrder;
    }

	public boolean isExpanded() {
		return expanded;
	}

	public void setExpanded(boolean expanded) {
		this.expanded = expanded;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	public String getHrefTarget() {
		return hrefTarget;
	}

	public void setHrefTarget(String hrefTarget) {
		this.hrefTarget = hrefTarget;
	}
    
}
