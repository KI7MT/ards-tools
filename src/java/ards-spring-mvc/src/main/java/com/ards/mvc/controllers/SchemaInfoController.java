package com.ards.mvc.controllers;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ards.mvc.models.SchemaInfo;
import com.ards.mvc.repositories.SchemaInfoRepository;

@Controller
public class SchemaInfoController {

	private static final Logger LOGGER = LoggerFactory.getLogger(SchemaInfoController.class);

	@Autowired
	private SchemaInfoRepository repository;

	@Autowired
	public SchemaInfoController(SchemaInfoRepository repository) {
		this.repository = repository;
		this.repository = repository;
	}
	
	// -----------------------------------------------------------------------
	// API Methods - use @ResponseBody to return JSON Objects
	// -----------------------------------------------------------------------
	@GetMapping(value = "/api/schemainfo", produces = "application/json")
	@ResponseBody
    public  List<SchemaInfo> getApiSchemaInfo(Model model)
    {
        List<SchemaInfo> schemaInfoList = repository.findAll();
        return schemaInfoList;
    }

	// -----------------------------------------------------------------------
	// MVC Methods
	// -----------------------------------------------------------------------

	@RequestMapping(value = "/SchemaInfo/list", method = RequestMethod.GET)
	public String getSchemaInfoList(Model model) {

		LOGGER.info("SchemaInfo: Items fetch all");
		LOGGER.info("--------------------------");
		// start execution timer
		long time = System.currentTimeMillis();
		
		// Get the list of Schemas
		LOGGER.info("SchemaInfo : Generate List<SchemaInfo>  ");
		List<SchemaInfo> schemaList = repository.findAll();

		// Add to schemaInfo 
		LOGGER.info("SchemaInfo: Add modele.attributes schemaList");
		model.addAttribute("schemaItems", schemaList);

		// Calculate Query TIme
		long exTime = System.currentTimeMillis() - time;
		double sec = exTime / 1000.0;
		
		LOGGER.info("SchemaInfo : Query Time");
		model.addAttribute("executionTime", "Query Time : " + sec + " seconds");
		System.out.printf("%nSchemaInfo: Query Time : %s%n", sec);
		
		// CONSOLE PRINT
		LOGGER.info("SchemaInfo Count");
		System.out.printf("Staff Count...: %s%n", schemaList.size());
		System.out.println(schemaList.toString());
		
		return "schemaInfo";
	}
}
