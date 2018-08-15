package com.iwe.avengers;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.exception.AvengerNotFoundException;
import com.iwe.avenger.lambda.response.HandlerResponse;
import com.iwe.avengers.dynamodb.dao.AvengerDao;

public class RemoveAvengerHandler implements RequestHandler<Avenger, HandlerResponse> {

	private AvengerDao dao = new AvengerDao();

	@Override
	public HandlerResponse handleRequest(final Avenger avenger, final Context context) {
		final String id = avenger.getId();
		
		context.getLogger().log("[#] - Initiate remove Avenger by id: " + id);
		
		if (dao.find(id) == null) {
			throw new AvengerNotFoundException("[NotFound] - Avenger id: " + id + " not found");
		}
		
		dao.remove(id);
		
		context.getLogger().log("[#] - Avenger deleted");
		
		final HandlerResponse response = HandlerResponse
				.builder()
				.setStatusCode(204)
				.build();

		return response;
	}

}
