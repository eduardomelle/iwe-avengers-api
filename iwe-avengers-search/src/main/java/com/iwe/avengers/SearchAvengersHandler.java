package com.iwe.avengers;

import java.util.NoSuchElementException;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.iwe.avenger.dynamodb.entity.Avenger;
import com.iwe.avenger.lambda.exception.AvengerNotFoundException;
import com.iwe.avenger.lambda.response.HandlerResponse;
import com.iwe.avengers.dynamodb.dao.AvengerDao;

public class SearchAvengersHandler implements RequestHandler<Avenger, HandlerResponse> {

	private AvengerDao dao = new AvengerDao();

	@Override
	public HandlerResponse handleRequest(final Avenger avenger, final Context context) {
		final String id = avenger.getId();

		try {
			context.getLogger().log("[#] - Initiate search Avenger by id: " + id);

			final Avenger avengerRetrieved = dao.find(id);

			/*
			 * if (avengerRetrieved == null) { throw new
			 * AvengerNotFoundException("[NotFound] - Avenger id: " + id + " not found"); }
			 */

			final HandlerResponse response = HandlerResponse.builder().setStatusCode(200)
					.setObjectBody(avengerRetrieved).build();

			context.getLogger().log("[#] - Avenger found " + avengerRetrieved.getName());

			return response;
		} catch (NoSuchElementException e) {
			throw new AvengerNotFoundException("[NotFound] - Avenger id: " + id + " not found");
		}
	}

}
