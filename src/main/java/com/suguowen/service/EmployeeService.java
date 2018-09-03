package com.suguowen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suguowen.bean.Employee;
import com.suguowen.bean.EmployeeExample;
import com.suguowen.bean.EmployeeExample.Criteria;
import com.suguowen.dao.EmployeeMapper;

@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;

	
	 //查询所有员工
	 
	public List<Employee> getAll() {
		
		System.out.println("==========进入Service=======");
		
		List<Employee> list = employeeMapper.selectByExampleWithDept(null);
		return list;
	}

	/*
	 * 按员工id查询员工
	 */
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	public Employee getEmp(Integer id) {
		Employee  employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/*
	 * 员工更新
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	/*
	 * 员工删除
	 */
	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	public void delectBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//delete from xxx where emp_id in(1,2,3)
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

}
