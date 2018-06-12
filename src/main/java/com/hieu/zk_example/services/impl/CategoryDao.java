package com.hieu.zk_example.services.impl;

import java.util.LinkedList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.zkoss.zul.ListModelList;

import com.hieu.zk_example.entity.Category;

@Repository
public class CategoryDao {

	@PersistenceContext
	private EntityManager em;

	@Transactional(readOnly = true)
	public List<Category> queryAll() {
		Query query = em.createQuery("SELECT c FROM Category c");
		List<Category> result = query.getResultList();
		return result;
	}

	@Transactional(readOnly = true)
	public Category get(Integer id) {
		return em.find(Category.class, id);
	}
//
//	@Transactional
//	public Log save(Log log) {
//		em.persist(log);
//		em.flush();
//		return log;
//	}
//
	@Transactional
	public void delete(Category cat) {
		Category r = get(cat.getId());
		if(r != null) {
			em.remove(r);
		}
	}

	@Transactional(readOnly = true)
	public List<Category> search(String keyword) {
		List<Category> list = queryAll();
		List<Category> result = new LinkedList<Category>();
		if (keyword==null || "".equals(keyword)) {
			result = list;
		}else {
			for (Category category : list) {
				if (category.getName().toLowerCase().contains(keyword.toLowerCase())) {
					result.add(category);
				}
			}
		}
		return result;
	}

}
