package com.iwe.avengers.dynamodb.dao;

import java.util.HashMap;
import java.util.Map;

import com.iwe.avenger.dynamodb.entity.Avenger;

public class AvengerDao {
	
	private Map<String, Avenger> mapper = new HashMap<>();
	
	public AvengerDao() {
		mapper.put("asas-sdsad-sdsa-asds", new Avenger("asas-sdsad-sdsa-asds", "Iron Man", "Tony Stark"));
		mapper.put("aaaa-aaaa-aaaa-aaaa", new Avenger("aaaa-aaaa-aaaa-aaaa", "Hulk", "Bruce Banner"));
	}
	
	public Avenger find(String id) {
		return mapper.get(id);
	}

}
