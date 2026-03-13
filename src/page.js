export default class Page {
  constructor() {
    this.element = document.createElement("div");
    this.element.className = "page";

    this.cardContainer = document.createElement("div");
    this.cardContainer.className = "card-container";

    this.element.appendChild(this.cardContainer);
  }

  addCard(cardElement) {
    this.cardContainer.appendChild(cardElement);
  }

  render() {
    return this.element;
  }
}
