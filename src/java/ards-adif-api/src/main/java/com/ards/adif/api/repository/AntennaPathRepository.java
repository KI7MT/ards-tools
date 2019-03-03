package com.ards.adif.api.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ards.adif.api.model.AntennaPath;

@Repository
public interface AntennaPathRepository extends JpaRepository<AntennaPath, Integer> {

}
