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

  it("adds item to cart when clicking cart, and increments My Cart", () => {
    cy.contains("My Cart (0)").should("exist");
    cy.get(".products article div .btn").first().click({ force: true });
    cy.contains("My Cart").should('contain', 'My Cart (1)');
  });

})