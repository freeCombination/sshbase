package com.hed.sshbase.attach.service;

import com.hed.sshbase.attach.entity.AttachGroup;

public interface IAttachGroupService {
	AttachGroup saveAttachGroup(AttachGroup attachGroup);
	
	AttachGroup getAttachGroup(Integer id);
	
	void removeAttachGroup(Integer id);
	
}
