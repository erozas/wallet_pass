import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["message", "closeButton"];

  connect() {
    // Auto-dismiss each message after 5 seconds
    this.messageTargets.forEach((message, index) => {
      setTimeout(() => {
        this.dismissMessage(message);
      }, 8000 + index * 500); // Stagger dismissal by 500ms
    });
  }

  dismiss(event) {
    const message = event.currentTarget.closest(
      "[data-flash-target='message']"
    );
    this.dismissMessage(message);
  }

  dismissMessage(message) {
    // Fade out the message
    message.style.opacity = "0";

    // Remove the message after fade transition completes
    setTimeout(() => {
      message.remove();

      // Remove the entire container if no messages left
      if (this.messageTargets.length === 0) {
        this.element.remove();
      }
    }, 300);
  }
}
