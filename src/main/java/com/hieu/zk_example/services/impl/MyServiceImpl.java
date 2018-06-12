package com.hieu.zk_example.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Service;
import org.zkoss.zul.ListModelList;

import com.hieu.zk_example.entity.Category;
import com.hieu.zk_example.services.MyService;

@Service("myService")
@Scope(value = "singleton", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class MyServiceImpl implements MyService {

	@Autowired
	CategoryDao dao;

//	public Log addLog(Log log) {
//		return dao.save(log);
//	}

	public List<Category> getList() {
		return dao.queryAll();
	}

	public void delete(Category cat) {
		dao.delete(cat);
	}

	public List<Category> search(String keyword) {
		return dao.search(keyword);
	}
	
	
//
//	public Category add(Category cat) {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//	public List<Category> getList() {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//	public void delete(Category cat) {
//		// TODO Auto-generated method stub
//		
//	}
	
	
	

}
