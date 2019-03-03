package com.ards.adif.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ards.adif.api.model.AntennaPath;
import com.ards.adif.api.service.AntennaPathService;

import io.swagger.annotations.Api;

@RestController
@RequestMapping("/api")
@Api(tags={"Antenna Path Controller"}, consumes="null")
public class AntennaPathController {

	private AntennaPathService antennaPathService;
	
	@Autowired
	 public void setAntennaPathService(AntennaPathService antennaPathService) {
	     this.antennaPathService = antennaPathService;
	}
	
	@RequestMapping(value = "/AntennaPath/List", method= RequestMethod.GET, produces = "application/json")
	public Iterable<AntennaPath> getAllAntennaPaths() {
	    return antennaPathService.listAllAntennaPaths();
	}

    @RequestMapping(value = "/AntennaPath/{id}", method= RequestMethod.GET, produces = "application/json")
	public AntennaPath showProduct(@PathVariable Integer id, Model model){
		AntennaPath antPath = antennaPathService.getAntennaPathById(id);
        return antPath;
	}
}
