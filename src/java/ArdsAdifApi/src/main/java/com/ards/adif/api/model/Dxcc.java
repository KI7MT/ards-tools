package com.ards.adif.api.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;

/**
 * The persistent class for the dxcc database table.
 * 
 */
@Entity
@Table(name = "dxcc")
@NamedQuery(name = "Dxcc.findAll", query = "SELECT d FROM Dxcc d")
public class Dxcc implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique = true, nullable = false)
	private Integer id;

	@Column(nullable = false, length = 4)
	private String code;

	@Column(name = "is_deleted")
	private Boolean isDeleted;

	@Column(nullable = false, length = 90)
	private String name;

	// bi-directional many-to-one association to ArrlSection
	@OneToMany(mappedBy = "dxcc")
	private List<ArrlSection> arrlSections;

	// bi-directional many-to-one association to Pas001
	@OneToMany(mappedBy = "dxcc")
	private List<Pas001> pas001s;

	// bi-directional many-to-one association to Pas005
	@OneToMany(mappedBy = "dxcc")
	private List<Pas005> pas005s;

	// bi-directional many-to-one association to Pas006
	@OneToMany(mappedBy = "dxcc")
	private List<Pas006> pas006s;

	// bi-directional many-to-one association to Pas015
	@OneToMany(mappedBy = "dxcc")
	private List<Pas015> pas015s;

	// bi-directional many-to-one association to Pas021
	@OneToMany(mappedBy = "dxcc")
	private List<Pas021> pas021s;

	// bi-directional many-to-one association to Pas027
	@OneToMany(mappedBy = "dxcc")
	private List<Pas027> pas027s;

	// bi-directional many-to-one association to Pas029
	@OneToMany(mappedBy = "dxcc")
	private List<Pas029> pas029s;

	// bi-directional many-to-one association to Pas032
	@OneToMany(mappedBy = "dxcc")
	private List<Pas032> pas032s;

	// bi-directional many-to-one association to Pas050
	@OneToMany(mappedBy = "dxcc")
	private List<Pas050> pas050s;

	// bi-directional many-to-one association to Pas052
	@OneToMany(mappedBy = "dxcc")
	private List<Pas052> pas052s;

	// bi-directional many-to-one association to Pas054
	@OneToMany(mappedBy = "dxcc")
	private List<Pas054> pas054s;

	// bi-directional many-to-one association to Pas061
	@OneToMany(mappedBy = "dxcc")
	private List<Pas061> pas061s;

	// bi-directional many-to-one association to Pas070
	@OneToMany(mappedBy = "dxcc")
	private List<Pas070> pas070s;

	// bi-directional many-to-one association to Pas074
	@OneToMany(mappedBy = "dxcc")
	private List<Pas074> pas074s;

	// bi-directional many-to-one association to Pas086
	@OneToMany(mappedBy = "dxcc")
	private List<Pas086> pas086s;

	// bi-directional many-to-one association to Pas100
	@OneToMany(mappedBy = "dxcc")
	private List<Pas100> pas100s;

	// bi-directional many-to-one association to Pas104
	@OneToMany(mappedBy = "dxcc")
	private List<Pas104> pas104s;

	// bi-directional many-to-one association to Pas108
	@OneToMany(mappedBy = "dxcc")
	private List<Pas108> pas108s;

	// bi-directional many-to-one association to Pas110
	@OneToMany(mappedBy = "dxcc")
	private List<Pas110> pas110s;

	// bi-directional many-to-one association to Pas112
	@OneToMany(mappedBy = "dxcc")
	private List<Pas112> pas112s;

	// bi-directional many-to-one association to Pas126
	@OneToMany(mappedBy = "dxcc")
	private List<Pas126> pas126s;

	// bi-directional many-to-one association to Pas130
	@OneToMany(mappedBy = "dxcc")
	private List<Pas130> pas130s;

	// bi-directional many-to-one association to Pas132
	@OneToMany(mappedBy = "dxcc")
	private List<Pas132> pas132s;

	// bi-directional many-to-one association to Pas137
	@OneToMany(mappedBy = "dxcc")
	private List<Pas137> pas137s;

	// bi-directional many-to-one association to Pas138
	@OneToMany(mappedBy = "dxcc")
	private List<Pas138> pas138s;

	// bi-directional many-to-one association to Pas144
	@OneToMany(mappedBy = "dxcc")
	private List<Pas144> pas144s;

	// bi-directional many-to-one association to Pas147
	@OneToMany(mappedBy = "dxcc")
	private List<Pas147> pas147s;

	// bi-directional many-to-one association to Pas148
	@OneToMany(mappedBy = "dxcc")
	private List<Pas148> pas148s;

	// bi-directional many-to-one association to Pas149
	@OneToMany(mappedBy = "dxcc")
	private List<Pas149> pas149s;

	// bi-directional many-to-one association to Pas150
	@OneToMany(mappedBy = "dxcc")
	private List<Pas150> pas150s;

	// bi-directional many-to-one association to Pas151
	@OneToMany(mappedBy = "dxcc")
	private List<Pas151> pas151s;

	// bi-directional many-to-one association to Pas153
	@OneToMany(mappedBy = "dxcc")
	private List<Pas153> pas153s;

	// bi-directional many-to-one association to Pas163
	@OneToMany(mappedBy = "dxcc")
	private List<Pas163> pas163s;

	// bi-directional many-to-one association to Pas170
	@OneToMany(mappedBy = "dxcc")
	private List<Pas170> pas170s;

	// bi-directional many-to-one association to Pas177
	@OneToMany(mappedBy = "dxcc")
	private List<Pas177> pas177s;

	// bi-directional many-to-one association to Pas179
	@OneToMany(mappedBy = "dxcc")
	private List<Pas179> pas179s;

	// bi-directional many-to-one association to Pas192
	@OneToMany(mappedBy = "dxcc")
	private List<Pas192> pas192s;

	// bi-directional many-to-one association to Pas206Region
	@OneToMany(mappedBy = "dxcc")
	private List<Pas206Region> pas206Regions;

	// bi-directional many-to-one association to Pas209
	@OneToMany(mappedBy = "dxcc")
	private List<Pas209> pas209s;

	// bi-directional many-to-one association to Pas212Region
	@OneToMany(mappedBy = "dxcc")
	private List<Pas212Region> pas212Regions;

	// bi-directional many-to-one association to Pas214
	@OneToMany(mappedBy = "dxcc")
	private List<Pas214> pas214s;

	// bi-directional many-to-one association to Pas221
	@OneToMany(mappedBy = "dxcc")
	private List<Pas221> pas221s;

	// bi-directional many-to-one association to Pas224Region
	@OneToMany(mappedBy = "dxcc")
	private List<Pas224Region> pas224Regions;

	// bi-directional many-to-one association to Pas225Region
	@OneToMany(mappedBy = "dxcc")
	private List<Pas225Region> pas225Regions;

	// bi-directional many-to-one association to Pas227
	@OneToMany(mappedBy = "dxcc")
	private List<Pas227> pas227s;

	// bi-directional many-to-one association to Pas230
	@OneToMany(mappedBy = "dxcc")
	private List<Pas230> pas230s;

	// bi-directional many-to-one association to Pas239
	@OneToMany(mappedBy = "dxcc")
	private List<Pas239> pas239s;

	// bi-directional many-to-one association to Pas245
	@OneToMany(mappedBy = "dxcc")
	private List<Pas245> pas245s;

	// bi-directional many-to-one association to Pas248Region
	@OneToMany(mappedBy = "dxcc")
	private List<Pas248Region> pas248Regions;

	// bi-directional many-to-one association to Pas256
	@OneToMany(mappedBy = "dxcc")
	private List<Pas256> pas256s;

	// bi-directional many-to-one association to Pas263
	@OneToMany(mappedBy = "dxcc")
	private List<Pas263> pas263s;

	// bi-directional many-to-one association to Pas269
	@OneToMany(mappedBy = "dxcc")
	private List<Pas269> pas269s;

	// bi-directional many-to-one association to Pas272
	@OneToMany(mappedBy = "dxcc")
	private List<Pas272> pas272s;

	// bi-directional many-to-one association to Pas275
	@OneToMany(mappedBy = "dxcc")
	private List<Pas275> pas275s;

	// bi-directional many-to-one association to Pas281
	@OneToMany(mappedBy = "dxcc")
	private List<Pas281> pas281s;

	// bi-directional many-to-one association to Pas284
	@OneToMany(mappedBy = "dxcc")
	private List<Pas284> pas284s;

	// bi-directional many-to-one association to Pas287
	@OneToMany(mappedBy = "dxcc")
	private List<Pas287> pas287s;

	// bi-directional many-to-one association to Pas288
	@OneToMany(mappedBy = "dxcc")
	private List<Pas288> pas288s;

	// bi-directional many-to-one association to Pas291
	@OneToMany(mappedBy = "dxcc")
	private List<Pas291> pas291s;

	// bi-directional many-to-one association to Pas318
	@OneToMany(mappedBy = "dxcc")
	private List<Pas318> pas318s;

	// bi-directional many-to-one association to Pas327
	@OneToMany(mappedBy = "dxcc")
	private List<Pas327> pas327s;

	// bi-directional many-to-one association to Pas339Region
	@OneToMany(mappedBy = "dxcc")
	private List<Pas339Region> pas339Regions;

	// bi-directional many-to-one association to Pas375Region
	@OneToMany(mappedBy = "dxcc")
	private List<Pas375Region> pas375Regions;

	// bi-directional many-to-one association to Pas386
	@OneToMany(mappedBy = "dxcc")
	private List<Pas386> pas386s;

	// bi-directional many-to-one association to Pas387
	@OneToMany(mappedBy = "dxcc")
	private List<Pas387> pas387s;

	// bi-directional many-to-one association to Pas497
	@OneToMany(mappedBy = "dxcc")
	private List<Pas497> pas497s;

	// bi-directional many-to-one association to Pas503Region
	@OneToMany(mappedBy = "dxcc")
	private List<Pas503Region> pas503Regions;

	// bi-directional many-to-one association to Pas504Region
	@OneToMany(mappedBy = "dxcc")
	private List<Pas504Region> pas504Regions;

	// bi-directional many-to-one association to PasSummary
	@OneToMany(mappedBy = "dxcc")
	private List<PasSummary> pasSummaries;

	// bi-directional many-to-one association to Region
	@OneToMany(mappedBy = "dxcc")
	private List<Region> regions;

	public Dxcc() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Boolean getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<ArrlSection> getArrlSections() {
		return this.arrlSections;
	}

	public void setArrlSections(List<ArrlSection> arrlSections) {
		this.arrlSections = arrlSections;
	}

	public ArrlSection addArrlSection(ArrlSection arrlSection) {
		getArrlSections().add(arrlSection);
		arrlSection.setDxcc(this);

		return arrlSection;
	}

	public ArrlSection removeArrlSection(ArrlSection arrlSection) {
		getArrlSections().remove(arrlSection);
		arrlSection.setDxcc(null);

		return arrlSection;
	}

	public List<Pas001> getPas001s() {
		return this.pas001s;
	}

	public void setPas001s(List<Pas001> pas001s) {
		this.pas001s = pas001s;
	}

	public Pas001 addPas001(Pas001 pas001) {
		getPas001s().add(pas001);
		pas001.setDxcc(this);

		return pas001;
	}

	public Pas001 removePas001(Pas001 pas001) {
		getPas001s().remove(pas001);
		pas001.setDxcc(null);

		return pas001;
	}

	public List<Pas005> getPas005s() {
		return this.pas005s;
	}

	public void setPas005s(List<Pas005> pas005s) {
		this.pas005s = pas005s;
	}

	public Pas005 addPas005(Pas005 pas005) {
		getPas005s().add(pas005);
		pas005.setDxcc(this);

		return pas005;
	}

	public Pas005 removePas005(Pas005 pas005) {
		getPas005s().remove(pas005);
		pas005.setDxcc(null);

		return pas005;
	}

	public List<Pas006> getPas006s() {
		return this.pas006s;
	}

	public void setPas006s(List<Pas006> pas006s) {
		this.pas006s = pas006s;
	}

	public Pas006 addPas006(Pas006 pas006) {
		getPas006s().add(pas006);
		pas006.setDxcc(this);

		return pas006;
	}

	public Pas006 removePas006(Pas006 pas006) {
		getPas006s().remove(pas006);
		pas006.setDxcc(null);

		return pas006;
	}

	public List<Pas015> getPas015s() {
		return this.pas015s;
	}

	public void setPas015s(List<Pas015> pas015s) {
		this.pas015s = pas015s;
	}

	public Pas015 addPas015(Pas015 pas015) {
		getPas015s().add(pas015);
		pas015.setDxcc(this);

		return pas015;
	}

	public Pas015 removePas015(Pas015 pas015) {
		getPas015s().remove(pas015);
		pas015.setDxcc(null);

		return pas015;
	}

	public List<Pas021> getPas021s() {
		return this.pas021s;
	}

	public void setPas021s(List<Pas021> pas021s) {
		this.pas021s = pas021s;
	}

	public Pas021 addPas021(Pas021 pas021) {
		getPas021s().add(pas021);
		pas021.setDxcc(this);

		return pas021;
	}

	public Pas021 removePas021(Pas021 pas021) {
		getPas021s().remove(pas021);
		pas021.setDxcc(null);

		return pas021;
	}

	public List<Pas027> getPas027s() {
		return this.pas027s;
	}

	public void setPas027s(List<Pas027> pas027s) {
		this.pas027s = pas027s;
	}

	public Pas027 addPas027(Pas027 pas027) {
		getPas027s().add(pas027);
		pas027.setDxcc(this);

		return pas027;
	}

	public Pas027 removePas027(Pas027 pas027) {
		getPas027s().remove(pas027);
		pas027.setDxcc(null);

		return pas027;
	}

	public List<Pas029> getPas029s() {
		return this.pas029s;
	}

	public void setPas029s(List<Pas029> pas029s) {
		this.pas029s = pas029s;
	}

	public Pas029 addPas029(Pas029 pas029) {
		getPas029s().add(pas029);
		pas029.setDxcc(this);

		return pas029;
	}

	public Pas029 removePas029(Pas029 pas029) {
		getPas029s().remove(pas029);
		pas029.setDxcc(null);

		return pas029;
	}

	public List<Pas032> getPas032s() {
		return this.pas032s;
	}

	public void setPas032s(List<Pas032> pas032s) {
		this.pas032s = pas032s;
	}

	public Pas032 addPas032(Pas032 pas032) {
		getPas032s().add(pas032);
		pas032.setDxcc(this);

		return pas032;
	}

	public Pas032 removePas032(Pas032 pas032) {
		getPas032s().remove(pas032);
		pas032.setDxcc(null);

		return pas032;
	}

	public List<Pas050> getPas050s() {
		return this.pas050s;
	}

	public void setPas050s(List<Pas050> pas050s) {
		this.pas050s = pas050s;
	}

	public Pas050 addPas050(Pas050 pas050) {
		getPas050s().add(pas050);
		pas050.setDxcc(this);

		return pas050;
	}

	public Pas050 removePas050(Pas050 pas050) {
		getPas050s().remove(pas050);
		pas050.setDxcc(null);

		return pas050;
	}

	public List<Pas052> getPas052s() {
		return this.pas052s;
	}

	public void setPas052s(List<Pas052> pas052s) {
		this.pas052s = pas052s;
	}

	public Pas052 addPas052(Pas052 pas052) {
		getPas052s().add(pas052);
		pas052.setDxcc(this);

		return pas052;
	}

	public Pas052 removePas052(Pas052 pas052) {
		getPas052s().remove(pas052);
		pas052.setDxcc(null);

		return pas052;
	}

	public List<Pas054> getPas054s() {
		return this.pas054s;
	}

	public void setPas054s(List<Pas054> pas054s) {
		this.pas054s = pas054s;
	}

	public Pas054 addPas054(Pas054 pas054) {
		getPas054s().add(pas054);
		pas054.setDxcc(this);

		return pas054;
	}

	public Pas054 removePas054(Pas054 pas054) {
		getPas054s().remove(pas054);
		pas054.setDxcc(null);

		return pas054;
	}

	public List<Pas061> getPas061s() {
		return this.pas061s;
	}

	public void setPas061s(List<Pas061> pas061s) {
		this.pas061s = pas061s;
	}

	public Pas061 addPas061(Pas061 pas061) {
		getPas061s().add(pas061);
		pas061.setDxcc(this);

		return pas061;
	}

	public Pas061 removePas061(Pas061 pas061) {
		getPas061s().remove(pas061);
		pas061.setDxcc(null);

		return pas061;
	}

	public List<Pas070> getPas070s() {
		return this.pas070s;
	}

	public void setPas070s(List<Pas070> pas070s) {
		this.pas070s = pas070s;
	}

	public Pas070 addPas070(Pas070 pas070) {
		getPas070s().add(pas070);
		pas070.setDxcc(this);

		return pas070;
	}

	public Pas070 removePas070(Pas070 pas070) {
		getPas070s().remove(pas070);
		pas070.setDxcc(null);

		return pas070;
	}

	public List<Pas074> getPas074s() {
		return this.pas074s;
	}

	public void setPas074s(List<Pas074> pas074s) {
		this.pas074s = pas074s;
	}

	public Pas074 addPas074(Pas074 pas074) {
		getPas074s().add(pas074);
		pas074.setDxcc(this);

		return pas074;
	}

	public Pas074 removePas074(Pas074 pas074) {
		getPas074s().remove(pas074);
		pas074.setDxcc(null);

		return pas074;
	}

	public List<Pas086> getPas086s() {
		return this.pas086s;
	}

	public void setPas086s(List<Pas086> pas086s) {
		this.pas086s = pas086s;
	}

	public Pas086 addPas086(Pas086 pas086) {
		getPas086s().add(pas086);
		pas086.setDxcc(this);

		return pas086;
	}

	public Pas086 removePas086(Pas086 pas086) {
		getPas086s().remove(pas086);
		pas086.setDxcc(null);

		return pas086;
	}

	public List<Pas100> getPas100s() {
		return this.pas100s;
	}

	public void setPas100s(List<Pas100> pas100s) {
		this.pas100s = pas100s;
	}

	public Pas100 addPas100(Pas100 pas100) {
		getPas100s().add(pas100);
		pas100.setDxcc(this);

		return pas100;
	}

	public Pas100 removePas100(Pas100 pas100) {
		getPas100s().remove(pas100);
		pas100.setDxcc(null);

		return pas100;
	}

	public List<Pas104> getPas104s() {
		return this.pas104s;
	}

	public void setPas104s(List<Pas104> pas104s) {
		this.pas104s = pas104s;
	}

	public Pas104 addPas104(Pas104 pas104) {
		getPas104s().add(pas104);
		pas104.setDxcc(this);

		return pas104;
	}

	public Pas104 removePas104(Pas104 pas104) {
		getPas104s().remove(pas104);
		pas104.setDxcc(null);

		return pas104;
	}

	public List<Pas108> getPas108s() {
		return this.pas108s;
	}

	public void setPas108s(List<Pas108> pas108s) {
		this.pas108s = pas108s;
	}

	public Pas108 addPas108(Pas108 pas108) {
		getPas108s().add(pas108);
		pas108.setDxcc(this);

		return pas108;
	}

	public Pas108 removePas108(Pas108 pas108) {
		getPas108s().remove(pas108);
		pas108.setDxcc(null);

		return pas108;
	}

	public List<Pas110> getPas110s() {
		return this.pas110s;
	}

	public void setPas110s(List<Pas110> pas110s) {
		this.pas110s = pas110s;
	}

	public Pas110 addPas110(Pas110 pas110) {
		getPas110s().add(pas110);
		pas110.setDxcc(this);

		return pas110;
	}

	public Pas110 removePas110(Pas110 pas110) {
		getPas110s().remove(pas110);
		pas110.setDxcc(null);

		return pas110;
	}

	public List<Pas112> getPas112s() {
		return this.pas112s;
	}

	public void setPas112s(List<Pas112> pas112s) {
		this.pas112s = pas112s;
	}

	public Pas112 addPas112(Pas112 pas112) {
		getPas112s().add(pas112);
		pas112.setDxcc(this);

		return pas112;
	}

	public Pas112 removePas112(Pas112 pas112) {
		getPas112s().remove(pas112);
		pas112.setDxcc(null);

		return pas112;
	}

	public List<Pas126> getPas126s() {
		return this.pas126s;
	}

	public void setPas126s(List<Pas126> pas126s) {
		this.pas126s = pas126s;
	}

	public Pas126 addPas126(Pas126 pas126) {
		getPas126s().add(pas126);
		pas126.setDxcc(this);

		return pas126;
	}

	public Pas126 removePas126(Pas126 pas126) {
		getPas126s().remove(pas126);
		pas126.setDxcc(null);

		return pas126;
	}

	public List<Pas130> getPas130s() {
		return this.pas130s;
	}

	public void setPas130s(List<Pas130> pas130s) {
		this.pas130s = pas130s;
	}

	public Pas130 addPas130(Pas130 pas130) {
		getPas130s().add(pas130);
		pas130.setDxcc(this);

		return pas130;
	}

	public Pas130 removePas130(Pas130 pas130) {
		getPas130s().remove(pas130);
		pas130.setDxcc(null);

		return pas130;
	}

	public List<Pas132> getPas132s() {
		return this.pas132s;
	}

	public void setPas132s(List<Pas132> pas132s) {
		this.pas132s = pas132s;
	}

	public Pas132 addPas132(Pas132 pas132) {
		getPas132s().add(pas132);
		pas132.setDxcc(this);

		return pas132;
	}

	public Pas132 removePas132(Pas132 pas132) {
		getPas132s().remove(pas132);
		pas132.setDxcc(null);

		return pas132;
	}

	public List<Pas137> getPas137s() {
		return this.pas137s;
	}

	public void setPas137s(List<Pas137> pas137s) {
		this.pas137s = pas137s;
	}

	public Pas137 addPas137(Pas137 pas137) {
		getPas137s().add(pas137);
		pas137.setDxcc(this);

		return pas137;
	}

	public Pas137 removePas137(Pas137 pas137) {
		getPas137s().remove(pas137);
		pas137.setDxcc(null);

		return pas137;
	}

	public List<Pas138> getPas138s() {
		return this.pas138s;
	}

	public void setPas138s(List<Pas138> pas138s) {
		this.pas138s = pas138s;
	}

	public Pas138 addPas138(Pas138 pas138) {
		getPas138s().add(pas138);
		pas138.setDxcc(this);

		return pas138;
	}

	public Pas138 removePas138(Pas138 pas138) {
		getPas138s().remove(pas138);
		pas138.setDxcc(null);

		return pas138;
	}

	public List<Pas144> getPas144s() {
		return this.pas144s;
	}

	public void setPas144s(List<Pas144> pas144s) {
		this.pas144s = pas144s;
	}

	public Pas144 addPas144(Pas144 pas144) {
		getPas144s().add(pas144);
		pas144.setDxcc(this);

		return pas144;
	}

	public Pas144 removePas144(Pas144 pas144) {
		getPas144s().remove(pas144);
		pas144.setDxcc(null);

		return pas144;
	}

	public List<Pas147> getPas147s() {
		return this.pas147s;
	}

	public void setPas147s(List<Pas147> pas147s) {
		this.pas147s = pas147s;
	}

	public Pas147 addPas147(Pas147 pas147) {
		getPas147s().add(pas147);
		pas147.setDxcc(this);

		return pas147;
	}

	public Pas147 removePas147(Pas147 pas147) {
		getPas147s().remove(pas147);
		pas147.setDxcc(null);

		return pas147;
	}

	public List<Pas148> getPas148s() {
		return this.pas148s;
	}

	public void setPas148s(List<Pas148> pas148s) {
		this.pas148s = pas148s;
	}

	public Pas148 addPas148(Pas148 pas148) {
		getPas148s().add(pas148);
		pas148.setDxcc(this);

		return pas148;
	}

	public Pas148 removePas148(Pas148 pas148) {
		getPas148s().remove(pas148);
		pas148.setDxcc(null);

		return pas148;
	}

	public List<Pas149> getPas149s() {
		return this.pas149s;
	}

	public void setPas149s(List<Pas149> pas149s) {
		this.pas149s = pas149s;
	}

	public Pas149 addPas149(Pas149 pas149) {
		getPas149s().add(pas149);
		pas149.setDxcc(this);

		return pas149;
	}

	public Pas149 removePas149(Pas149 pas149) {
		getPas149s().remove(pas149);
		pas149.setDxcc(null);

		return pas149;
	}

	public List<Pas150> getPas150s() {
		return this.pas150s;
	}

	public void setPas150s(List<Pas150> pas150s) {
		this.pas150s = pas150s;
	}

	public Pas150 addPas150(Pas150 pas150) {
		getPas150s().add(pas150);
		pas150.setDxcc(this);

		return pas150;
	}

	public Pas150 removePas150(Pas150 pas150) {
		getPas150s().remove(pas150);
		pas150.setDxcc(null);

		return pas150;
	}

	public List<Pas151> getPas151s() {
		return this.pas151s;
	}

	public void setPas151s(List<Pas151> pas151s) {
		this.pas151s = pas151s;
	}

	public Pas151 addPas151(Pas151 pas151) {
		getPas151s().add(pas151);
		pas151.setDxcc(this);

		return pas151;
	}

	public Pas151 removePas151(Pas151 pas151) {
		getPas151s().remove(pas151);
		pas151.setDxcc(null);

		return pas151;
	}

	public List<Pas153> getPas153s() {
		return this.pas153s;
	}

	public void setPas153s(List<Pas153> pas153s) {
		this.pas153s = pas153s;
	}

	public Pas153 addPas153(Pas153 pas153) {
		getPas153s().add(pas153);
		pas153.setDxcc(this);

		return pas153;
	}

	public Pas153 removePas153(Pas153 pas153) {
		getPas153s().remove(pas153);
		pas153.setDxcc(null);

		return pas153;
	}

	public List<Pas163> getPas163s() {
		return this.pas163s;
	}

	public void setPas163s(List<Pas163> pas163s) {
		this.pas163s = pas163s;
	}

	public Pas163 addPas163(Pas163 pas163) {
		getPas163s().add(pas163);
		pas163.setDxcc(this);

		return pas163;
	}

	public Pas163 removePas163(Pas163 pas163) {
		getPas163s().remove(pas163);
		pas163.setDxcc(null);

		return pas163;
	}

	public List<Pas170> getPas170s() {
		return this.pas170s;
	}

	public void setPas170s(List<Pas170> pas170s) {
		this.pas170s = pas170s;
	}

	public Pas170 addPas170(Pas170 pas170) {
		getPas170s().add(pas170);
		pas170.setDxcc(this);

		return pas170;
	}

	public Pas170 removePas170(Pas170 pas170) {
		getPas170s().remove(pas170);
		pas170.setDxcc(null);

		return pas170;
	}

	public List<Pas177> getPas177s() {
		return this.pas177s;
	}

	public void setPas177s(List<Pas177> pas177s) {
		this.pas177s = pas177s;
	}

	public Pas177 addPas177(Pas177 pas177) {
		getPas177s().add(pas177);
		pas177.setDxcc(this);

		return pas177;
	}

	public Pas177 removePas177(Pas177 pas177) {
		getPas177s().remove(pas177);
		pas177.setDxcc(null);

		return pas177;
	}

	public List<Pas179> getPas179s() {
		return this.pas179s;
	}

	public void setPas179s(List<Pas179> pas179s) {
		this.pas179s = pas179s;
	}

	public Pas179 addPas179(Pas179 pas179) {
		getPas179s().add(pas179);
		pas179.setDxcc(this);

		return pas179;
	}

	public Pas179 removePas179(Pas179 pas179) {
		getPas179s().remove(pas179);
		pas179.setDxcc(null);

		return pas179;
	}

	public List<Pas192> getPas192s() {
		return this.pas192s;
	}

	public void setPas192s(List<Pas192> pas192s) {
		this.pas192s = pas192s;
	}

	public Pas192 addPas192(Pas192 pas192) {
		getPas192s().add(pas192);
		pas192.setDxcc(this);

		return pas192;
	}

	public Pas192 removePas192(Pas192 pas192) {
		getPas192s().remove(pas192);
		pas192.setDxcc(null);

		return pas192;
	}

	public List<Pas206Region> getPas206Regions() {
		return this.pas206Regions;
	}

	public void setPas206Regions(List<Pas206Region> pas206Regions) {
		this.pas206Regions = pas206Regions;
	}

	public Pas206Region addPas206Region(Pas206Region pas206Region) {
		getPas206Regions().add(pas206Region);
		pas206Region.setDxcc(this);

		return pas206Region;
	}

	public Pas206Region removePas206Region(Pas206Region pas206Region) {
		getPas206Regions().remove(pas206Region);
		pas206Region.setDxcc(null);

		return pas206Region;
	}

	public List<Pas209> getPas209s() {
		return this.pas209s;
	}

	public void setPas209s(List<Pas209> pas209s) {
		this.pas209s = pas209s;
	}

	public Pas209 addPas209(Pas209 pas209) {
		getPas209s().add(pas209);
		pas209.setDxcc(this);

		return pas209;
	}

	public Pas209 removePas209(Pas209 pas209) {
		getPas209s().remove(pas209);
		pas209.setDxcc(null);

		return pas209;
	}

	public List<Pas212Region> getPas212Regions() {
		return this.pas212Regions;
	}

	public void setPas212Regions(List<Pas212Region> pas212Regions) {
		this.pas212Regions = pas212Regions;
	}

	public Pas212Region addPas212Region(Pas212Region pas212Region) {
		getPas212Regions().add(pas212Region);
		pas212Region.setDxcc(this);

		return pas212Region;
	}

	public Pas212Region removePas212Region(Pas212Region pas212Region) {
		getPas212Regions().remove(pas212Region);
		pas212Region.setDxcc(null);

		return pas212Region;
	}

	public List<Pas214> getPas214s() {
		return this.pas214s;
	}

	public void setPas214s(List<Pas214> pas214s) {
		this.pas214s = pas214s;
	}

	public Pas214 addPas214(Pas214 pas214) {
		getPas214s().add(pas214);
		pas214.setDxcc(this);

		return pas214;
	}

	public Pas214 removePas214(Pas214 pas214) {
		getPas214s().remove(pas214);
		pas214.setDxcc(null);

		return pas214;
	}

	public List<Pas221> getPas221s() {
		return this.pas221s;
	}

	public void setPas221s(List<Pas221> pas221s) {
		this.pas221s = pas221s;
	}

	public Pas221 addPas221(Pas221 pas221) {
		getPas221s().add(pas221);
		pas221.setDxcc(this);

		return pas221;
	}

	public Pas221 removePas221(Pas221 pas221) {
		getPas221s().remove(pas221);
		pas221.setDxcc(null);

		return pas221;
	}

	public List<Pas224Region> getPas224Regions() {
		return this.pas224Regions;
	}

	public void setPas224Regions(List<Pas224Region> pas224Regions) {
		this.pas224Regions = pas224Regions;
	}

	public Pas224Region addPas224Region(Pas224Region pas224Region) {
		getPas224Regions().add(pas224Region);
		pas224Region.setDxcc(this);

		return pas224Region;
	}

	public Pas224Region removePas224Region(Pas224Region pas224Region) {
		getPas224Regions().remove(pas224Region);
		pas224Region.setDxcc(null);

		return pas224Region;
	}

	public List<Pas225Region> getPas225Regions() {
		return this.pas225Regions;
	}

	public void setPas225Regions(List<Pas225Region> pas225Regions) {
		this.pas225Regions = pas225Regions;
	}

	public Pas225Region addPas225Region(Pas225Region pas225Region) {
		getPas225Regions().add(pas225Region);
		pas225Region.setDxcc(this);

		return pas225Region;
	}

	public Pas225Region removePas225Region(Pas225Region pas225Region) {
		getPas225Regions().remove(pas225Region);
		pas225Region.setDxcc(null);

		return pas225Region;
	}

	public List<Pas227> getPas227s() {
		return this.pas227s;
	}

	public void setPas227s(List<Pas227> pas227s) {
		this.pas227s = pas227s;
	}

	public Pas227 addPas227(Pas227 pas227) {
		getPas227s().add(pas227);
		pas227.setDxcc(this);

		return pas227;
	}

	public Pas227 removePas227(Pas227 pas227) {
		getPas227s().remove(pas227);
		pas227.setDxcc(null);

		return pas227;
	}

	public List<Pas230> getPas230s() {
		return this.pas230s;
	}

	public void setPas230s(List<Pas230> pas230s) {
		this.pas230s = pas230s;
	}

	public Pas230 addPas230(Pas230 pas230) {
		getPas230s().add(pas230);
		pas230.setDxcc(this);

		return pas230;
	}

	public Pas230 removePas230(Pas230 pas230) {
		getPas230s().remove(pas230);
		pas230.setDxcc(null);

		return pas230;
	}

	public List<Pas239> getPas239s() {
		return this.pas239s;
	}

	public void setPas239s(List<Pas239> pas239s) {
		this.pas239s = pas239s;
	}

	public Pas239 addPas239(Pas239 pas239) {
		getPas239s().add(pas239);
		pas239.setDxcc(this);

		return pas239;
	}

	public Pas239 removePas239(Pas239 pas239) {
		getPas239s().remove(pas239);
		pas239.setDxcc(null);

		return pas239;
	}

	public List<Pas245> getPas245s() {
		return this.pas245s;
	}

	public void setPas245s(List<Pas245> pas245s) {
		this.pas245s = pas245s;
	}

	public Pas245 addPas245(Pas245 pas245) {
		getPas245s().add(pas245);
		pas245.setDxcc(this);

		return pas245;
	}

	public Pas245 removePas245(Pas245 pas245) {
		getPas245s().remove(pas245);
		pas245.setDxcc(null);

		return pas245;
	}

	public List<Pas248Region> getPas248Regions() {
		return this.pas248Regions;
	}

	public void setPas248Regions(List<Pas248Region> pas248Regions) {
		this.pas248Regions = pas248Regions;
	}

	public Pas248Region addPas248Region(Pas248Region pas248Region) {
		getPas248Regions().add(pas248Region);
		pas248Region.setDxcc(this);

		return pas248Region;
	}

	public Pas248Region removePas248Region(Pas248Region pas248Region) {
		getPas248Regions().remove(pas248Region);
		pas248Region.setDxcc(null);

		return pas248Region;
	}

	public List<Pas256> getPas256s() {
		return this.pas256s;
	}

	public void setPas256s(List<Pas256> pas256s) {
		this.pas256s = pas256s;
	}

	public Pas256 addPas256(Pas256 pas256) {
		getPas256s().add(pas256);
		pas256.setDxcc(this);

		return pas256;
	}

	public Pas256 removePas256(Pas256 pas256) {
		getPas256s().remove(pas256);
		pas256.setDxcc(null);

		return pas256;
	}

	public List<Pas263> getPas263s() {
		return this.pas263s;
	}

	public void setPas263s(List<Pas263> pas263s) {
		this.pas263s = pas263s;
	}

	public Pas263 addPas263(Pas263 pas263) {
		getPas263s().add(pas263);
		pas263.setDxcc(this);

		return pas263;
	}

	public Pas263 removePas263(Pas263 pas263) {
		getPas263s().remove(pas263);
		pas263.setDxcc(null);

		return pas263;
	}

	public List<Pas269> getPas269s() {
		return this.pas269s;
	}

	public void setPas269s(List<Pas269> pas269s) {
		this.pas269s = pas269s;
	}

	public Pas269 addPas269(Pas269 pas269) {
		getPas269s().add(pas269);
		pas269.setDxcc(this);

		return pas269;
	}

	public Pas269 removePas269(Pas269 pas269) {
		getPas269s().remove(pas269);
		pas269.setDxcc(null);

		return pas269;
	}

	public List<Pas272> getPas272s() {
		return this.pas272s;
	}

	public void setPas272s(List<Pas272> pas272s) {
		this.pas272s = pas272s;
	}

	public Pas272 addPas272(Pas272 pas272) {
		getPas272s().add(pas272);
		pas272.setDxcc(this);

		return pas272;
	}

	public Pas272 removePas272(Pas272 pas272) {
		getPas272s().remove(pas272);
		pas272.setDxcc(null);

		return pas272;
	}

	public List<Pas275> getPas275s() {
		return this.pas275s;
	}

	public void setPas275s(List<Pas275> pas275s) {
		this.pas275s = pas275s;
	}

	public Pas275 addPas275(Pas275 pas275) {
		getPas275s().add(pas275);
		pas275.setDxcc(this);

		return pas275;
	}

	public Pas275 removePas275(Pas275 pas275) {
		getPas275s().remove(pas275);
		pas275.setDxcc(null);

		return pas275;
	}

	public List<Pas281> getPas281s() {
		return this.pas281s;
	}

	public void setPas281s(List<Pas281> pas281s) {
		this.pas281s = pas281s;
	}

	public Pas281 addPas281(Pas281 pas281) {
		getPas281s().add(pas281);
		pas281.setDxcc(this);

		return pas281;
	}

	public Pas281 removePas281(Pas281 pas281) {
		getPas281s().remove(pas281);
		pas281.setDxcc(null);

		return pas281;
	}

	public List<Pas284> getPas284s() {
		return this.pas284s;
	}

	public void setPas284s(List<Pas284> pas284s) {
		this.pas284s = pas284s;
	}

	public Pas284 addPas284(Pas284 pas284) {
		getPas284s().add(pas284);
		pas284.setDxcc(this);

		return pas284;
	}

	public Pas284 removePas284(Pas284 pas284) {
		getPas284s().remove(pas284);
		pas284.setDxcc(null);

		return pas284;
	}

	public List<Pas287> getPas287s() {
		return this.pas287s;
	}

	public void setPas287s(List<Pas287> pas287s) {
		this.pas287s = pas287s;
	}

	public Pas287 addPas287(Pas287 pas287) {
		getPas287s().add(pas287);
		pas287.setDxcc(this);

		return pas287;
	}

	public Pas287 removePas287(Pas287 pas287) {
		getPas287s().remove(pas287);
		pas287.setDxcc(null);

		return pas287;
	}

	public List<Pas288> getPas288s() {
		return this.pas288s;
	}

	public void setPas288s(List<Pas288> pas288s) {
		this.pas288s = pas288s;
	}

	public Pas288 addPas288(Pas288 pas288) {
		getPas288s().add(pas288);
		pas288.setDxcc(this);

		return pas288;
	}

	public Pas288 removePas288(Pas288 pas288) {
		getPas288s().remove(pas288);
		pas288.setDxcc(null);

		return pas288;
	}

	public List<Pas291> getPas291s() {
		return this.pas291s;
	}

	public void setPas291s(List<Pas291> pas291s) {
		this.pas291s = pas291s;
	}

	public Pas291 addPas291(Pas291 pas291) {
		getPas291s().add(pas291);
		pas291.setDxcc(this);

		return pas291;
	}

	public Pas291 removePas291(Pas291 pas291) {
		getPas291s().remove(pas291);
		pas291.setDxcc(null);

		return pas291;
	}

	public List<Pas318> getPas318s() {
		return this.pas318s;
	}

	public void setPas318s(List<Pas318> pas318s) {
		this.pas318s = pas318s;
	}

	public Pas318 addPas318(Pas318 pas318) {
		getPas318s().add(pas318);
		pas318.setDxcc(this);

		return pas318;
	}

	public Pas318 removePas318(Pas318 pas318) {
		getPas318s().remove(pas318);
		pas318.setDxcc(null);

		return pas318;
	}

	public List<Pas327> getPas327s() {
		return this.pas327s;
	}

	public void setPas327s(List<Pas327> pas327s) {
		this.pas327s = pas327s;
	}

	public Pas327 addPas327(Pas327 pas327) {
		getPas327s().add(pas327);
		pas327.setDxcc(this);

		return pas327;
	}

	public Pas327 removePas327(Pas327 pas327) {
		getPas327s().remove(pas327);
		pas327.setDxcc(null);

		return pas327;
	}

	public List<Pas339Region> getPas339Regions() {
		return this.pas339Regions;
	}

	public void setPas339Regions(List<Pas339Region> pas339Regions) {
		this.pas339Regions = pas339Regions;
	}

	public Pas339Region addPas339Region(Pas339Region pas339Region) {
		getPas339Regions().add(pas339Region);
		pas339Region.setDxcc(this);

		return pas339Region;
	}

	public Pas339Region removePas339Region(Pas339Region pas339Region) {
		getPas339Regions().remove(pas339Region);
		pas339Region.setDxcc(null);

		return pas339Region;
	}

	public List<Pas375Region> getPas375Regions() {
		return this.pas375Regions;
	}

	public void setPas375Regions(List<Pas375Region> pas375Regions) {
		this.pas375Regions = pas375Regions;
	}

	public Pas375Region addPas375Region(Pas375Region pas375Region) {
		getPas375Regions().add(pas375Region);
		pas375Region.setDxcc(this);

		return pas375Region;
	}

	public Pas375Region removePas375Region(Pas375Region pas375Region) {
		getPas375Regions().remove(pas375Region);
		pas375Region.setDxcc(null);

		return pas375Region;
	}

	public List<Pas386> getPas386s() {
		return this.pas386s;
	}

	public void setPas386s(List<Pas386> pas386s) {
		this.pas386s = pas386s;
	}

	public Pas386 addPas386(Pas386 pas386) {
		getPas386s().add(pas386);
		pas386.setDxcc(this);

		return pas386;
	}

	public Pas386 removePas386(Pas386 pas386) {
		getPas386s().remove(pas386);
		pas386.setDxcc(null);

		return pas386;
	}

	public List<Pas387> getPas387s() {
		return this.pas387s;
	}

	public void setPas387s(List<Pas387> pas387s) {
		this.pas387s = pas387s;
	}

	public Pas387 addPas387(Pas387 pas387) {
		getPas387s().add(pas387);
		pas387.setDxcc(this);

		return pas387;
	}

	public Pas387 removePas387(Pas387 pas387) {
		getPas387s().remove(pas387);
		pas387.setDxcc(null);

		return pas387;
	}

	public List<Pas497> getPas497s() {
		return this.pas497s;
	}

	public void setPas497s(List<Pas497> pas497s) {
		this.pas497s = pas497s;
	}

	public Pas497 addPas497(Pas497 pas497) {
		getPas497s().add(pas497);
		pas497.setDxcc(this);

		return pas497;
	}

	public Pas497 removePas497(Pas497 pas497) {
		getPas497s().remove(pas497);
		pas497.setDxcc(null);

		return pas497;
	}

	public List<Pas503Region> getPas503Regions() {
		return this.pas503Regions;
	}

	public void setPas503Regions(List<Pas503Region> pas503Regions) {
		this.pas503Regions = pas503Regions;
	}

	public Pas503Region addPas503Region(Pas503Region pas503Region) {
		getPas503Regions().add(pas503Region);
		pas503Region.setDxcc(this);

		return pas503Region;
	}

	public Pas503Region removePas503Region(Pas503Region pas503Region) {
		getPas503Regions().remove(pas503Region);
		pas503Region.setDxcc(null);

		return pas503Region;
	}

	public List<Pas504Region> getPas504Regions() {
		return this.pas504Regions;
	}

	public void setPas504Regions(List<Pas504Region> pas504Regions) {
		this.pas504Regions = pas504Regions;
	}

	public Pas504Region addPas504Region(Pas504Region pas504Region) {
		getPas504Regions().add(pas504Region);
		pas504Region.setDxcc(this);

		return pas504Region;
	}

	public Pas504Region removePas504Region(Pas504Region pas504Region) {
		getPas504Regions().remove(pas504Region);
		pas504Region.setDxcc(null);

		return pas504Region;
	}

	public List<PasSummary> getPasSummaries() {
		return this.pasSummaries;
	}

	public void setPasSummaries(List<PasSummary> pasSummaries) {
		this.pasSummaries = pasSummaries;
	}

	public PasSummary addPasSummary(PasSummary pasSummary) {
		getPasSummaries().add(pasSummary);
		pasSummary.setDxcc(this);

		return pasSummary;
	}

	public PasSummary removePasSummary(PasSummary pasSummary) {
		getPasSummaries().remove(pasSummary);
		pasSummary.setDxcc(null);

		return pasSummary;
	}

	public List<Region> getRegions() {
		return this.regions;
	}

	public void setRegions(List<Region> regions) {
		this.regions = regions;
	}

	public Region addRegion(Region region) {
		getRegions().add(region);
		region.setDxcc(this);

		return region;
	}

	public Region removeRegion(Region region) {
		getRegions().remove(region);
		region.setDxcc(null);

		return region;
	}

}