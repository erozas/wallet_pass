import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["quantity", "totalPrice", "submitButton"]
  static values = { 
    ticketPrice: Number,
    maxCapacity: Number,
    ticketsSold: Number
  }

  connect() {
    this.updateTotalPrice()
    this.updateAvailability()
  }

  quantityChanged() {
    this.updateTotalPrice()
    this.updateAvailability()
  }

  increment() {
    const currentQuantity = parseInt(this.quantityTarget.value)
    const maxAvailable = this.maxCapacityValue - this.ticketsSoldValue
    
    if (currentQuantity < Math.min(10, maxAvailable)) {
      this.quantityTarget.value = currentQuantity + 1
      this.updateTotalPrice()
      this.updateAvailability()
    }
  }

  decrement() {
    const currentQuantity = parseInt(this.quantityTarget.value)
    if (currentQuantity > 1) {
      this.quantityTarget.value = currentQuantity - 1
      this.updateTotalPrice()
      this.updateAvailability()
    }
  }

  updateTotalPrice() {
    const quantity = parseInt(this.quantityTarget.value)
    const total = this.ticketPriceValue * quantity

    if (this.hasTotalPriceTarget) {
      if (total === 0) {
        this.totalPriceTarget.textContent = "Free"
      } else {
        this.totalPriceTarget.textContent = `$${(total / 100).toFixed(2)}`
      }
    }
  }

  updateAvailability() {
    const quantity = parseInt(this.quantityTarget.value)
    const maxAvailable = this.maxCapacityValue - this.ticketsSoldValue
    
    if (this.hasSubmitButtonTarget) {
      if (quantity > maxAvailable) {
        this.submitButtonTarget.disabled = true
        this.submitButtonTarget.textContent = "Not Available"
        this.submitButtonTarget.classList.add("bg-gray-300", "text-gray-500", "cursor-not-allowed")
        this.submitButtonTarget.classList.remove("bg-blue-600", "hover:bg-blue-700", "text-white")
      } else {
        this.submitButtonTarget.disabled = false
        this.submitButtonTarget.textContent = `Get ${quantity} ${quantity === 1 ? 'Ticket' : 'Tickets'}`
        this.submitButtonTarget.classList.remove("bg-gray-300", "text-gray-500", "cursor-not-allowed")
        this.submitButtonTarget.classList.add("bg-blue-600", "hover:bg-blue-700", "text-white")
      }
    }
  }
}