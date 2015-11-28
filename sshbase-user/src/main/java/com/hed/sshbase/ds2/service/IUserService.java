package com.hed.sshbase.ds2.service;

import java.util.List;

import com.hed.sshbase.ds2.entity.User;

/**
 * 用户服务 定义用户服务中的方法
 */
public interface IUserService {
    
    /**
     * 获取所有用户列表
     * 
     * @Title getAllUser
     * @return List<User>
     */
    public List<User> getAllUser()
        throws Exception;
    
    /**
     * 添加或修改用户
     * 
     * @Title addUpdateUser
     * @param user 用户对象
     */
    public void addUpdateUser(User user)
        throws Exception;
}
