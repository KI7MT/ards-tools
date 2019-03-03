package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the credit_sponsor database table.
 * 
 */
@Entity
@Table(name="credit_sponsor")
@NamedQuery(name="CreditSponsor.findAll", query="SELECT c FROM CreditSponsor c")
public class CreditSponsor implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false)
	private Integer id;

	@Column(length=20)
	private String name;

	//bi-directional many-to-one association to Credit
	@OneToMany(mappedBy="creditSponsor")
	private List<Credit> credits;

	public CreditSponsor() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Credit> getCredits() {
		return this.credits;
	}

	public void setCredits(List<Credit> credits) {
		this.credits = credits;
	}

	public Credit addCredit(Credit credit) {
		getCredits().add(credit);
		credit.setCreditSponsor(this);

		return credit;
	}

	public Credit removeCredit(Credit credit) {
		getCredits().remove(credit);
		credit.setCreditSponsor(null);

		return credit;
	}

}