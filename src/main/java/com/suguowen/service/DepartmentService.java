package com.suguowen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suguowen.bean.Department;
import com.suguowen.bean.DepartmentExample;
import com.suguowen.bean.Employee;
import com.suguowen.dao.DepartmentMapper;

@Service
public class DepartmentService {
	@Autowired
	private DepartmentMapper deptmentMapper;
	
	public List<Department> getDepts() {
		System.out.println("=========进入service=======");
		List<Department> list = deptmentMapper.selectByExample(null);
		return list;
	}


}
