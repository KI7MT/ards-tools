package com.ards.adif.api.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ards.adif.api.model.AntennaPath;
import com.ards.adif.api.repository.AntennaPathRepository;
import com.ards.adif.api.service.AntennaPathService;

@Service
public class AntennaPathServiceImpl implements AntennaPathService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private AntennaPathRepository antennaPathRepository;
	
	@Autowired
    public void setAntennapathRepository(AntennaPathRepository antennaPathRepository) {
        this.antennaPathRepository = antennaPathRepository;
	}
	
	@Override
	public Iterable<AntennaPath> listAllAntennaPaths() {
		logger.debug("listAllAntennaPaths called");
	    return antennaPathRepository.findAll();
	}

	@Override
	public AntennaPath getAntennaPathById(Integer id) {
		logger.debug("findById(id) called");
		return antennaPathRepository.findById(id).orElse(null);
	} 
}
