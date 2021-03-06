const H1_ManageTags_Xp = "//h1[text()='Manage Tags']";
const TH_TagName_Xp = "//table//th[text()='Name']";
const Link_Delete_Xp = "//td/a[text()='Delete']";
const Link_BackToTagList_Xp = "//a[normalize-space(.)='Back to tag list']";

class Admin {
  verifyManageTagsHeader()
  {
    cy.xpath(H1_ManageTags_Xp).should('exist');
  }

  clickBackToTagList()
  {
    cy.xpath(Link_BackToTagList_Xp).click();
  }

  verifyTagList()
  {
    cy.xpath(TH_TagName_Xp).should("exist");
    var taglist = [];
    cy.getTagList().as('dbResultTagList');
    cy.get('@dbResultTagList').then((res) => {
      taglist = res
      taglist.forEach(element => {
        cy.xpath("//table//tr[contains(.,'" + element.name + "')]" + Link_Delete_Xp).should('exist');
      });
    })
  }

  verifyListedMeasureOnDelete(tagname)
  {
    
    var measurelist = [];
    cy.getTagedMeasure(tagname).as('dbResudbResultMeasurelistltTagList');
    cy.get('@dbResultMeasurelist').then((res) => {
      cy.xpath("//table//tr[contains(.,'" + tagname+ "')]" + Link_Delete_Xp).click();
      measurelist = res
      measurelist.forEach(element => {
        cy.xpath("//table//tr/td[.='" + element.id + "']/following-sibling::td[.='" + element.name + "']").should('exist');
      });
      this.clickBackToTagList();
    })
  }
}
export default Admin;