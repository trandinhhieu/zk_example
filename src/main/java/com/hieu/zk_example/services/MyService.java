package com.hieu.zk_example.services;

import java.util.List;

import com.hieu.zk_example.entity.Category;

public interface MyService {

	//Category add(Category cat);

	List<Category> getList();

	void delete(Category cat);

	List<Category> search(String keyword);
}
