describe('example to-do app', () => {
  
  beforeEach(() => {
    cy.visit('/')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("renders product detail page by clicking on a product", () => {
    cy.get('[alt="Scented Blade"]').click();
    cy.get(".product-detail").should("exist");
  });

})