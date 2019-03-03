package com.ards.adif.api.service;

import com.ards.adif.api.model.AntennaPath;

public interface AntennaPathService {

	Iterable<AntennaPath> listAllAntennaPaths();

	AntennaPath getAntennaPathById(Integer id);
		
}
