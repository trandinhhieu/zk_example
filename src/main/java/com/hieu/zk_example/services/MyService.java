package com.hieu.zk_example.services;

import java.util.List;

import com.hieu.zk_example.entity.Category;

public interface MyService {

	//Category add(Category cat);

	List<Category> getList();

	void delete(Category cat);

	Category search(String keyword);
}
