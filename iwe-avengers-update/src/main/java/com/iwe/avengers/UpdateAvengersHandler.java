package com.iwe.avengers;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.exception.AvengerNotFoundException;
import com.iwe.avenger.lambda.response.HandlerResponse;
import com.iwe.avengers.dynamodb.dao.AvengerDao;

public class UpdateAvengersHandler implements RequestHandler<Avenger, HandlerResponse> {

	private AvengerDao dao = new AvengerDao();

	@Override
	public HandlerResponse handleRequest(final Avenger avenger, final Context context) {
		final String id = avenger.getId();

		context.getLogger().log("[#] - Searching Avenger with id: " + id);

		final Avenger retrivedAvenger = dao.find(id);

		if (retrivedAvenger == null) {
			throw new AvengerNotFoundException("[NotFound] - Avenger id: " + id + " not found");
		}

		context.getLogger().log("[#] - Avenger found! Updating...");
		
		retrivedAvenger.setName(avenger.getName());
		retrivedAvenger.setSecretIdentity(avenger.getSecretIdentity());
		
		final Avenger a = dao.save(retrivedAvenger);

		context.getLogger().log("[#] - Successfully updated Avenger");

		final HandlerResponse response = HandlerResponse.builder().setStatusCode(200).setObjectBody(a).build();

		return response;
	}

}
