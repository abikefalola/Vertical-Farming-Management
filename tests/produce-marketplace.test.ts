import { describe, it, expect, beforeEach } from 'vitest'

describe('Produce Marketplace', () => {
  let produceListings = {}
  let nextListingId = 1
  
  const mockCreateListing = (farmId, cropId, quantity, price, seller) => {
    const listingId = nextListingId++
    produceListings[listingId] = { farmId, cropId, quantity, price, seller }
    return { success: true, listingId }
  }
  
  const mockBuyProduce = (listingId, quantity, buyer) => {
    const listing = produceListings[listingId]
    if (!listing || listing.quantity < quantity) {
      return { success: false, error: 'Invalid listing or insufficient quantity' }
    }
    listing.quantity -= quantity
    if (listing.quantity === 0) {
      delete produceListings[listingId]
    }
    return { success: true }
  }
  
  const mockGetListing = (listingId) => {
    return produceListings[listingId] || null
  }
  
  beforeEach(() => {
    produceListings = {}
    nextListingId = 1
  })
  
  it('should create and manage produce listings', () => {
    const result = mockCreateListing(1, 1, 100, 50, 'farmer1')
    expect(result.success).toBe(true)
    expect(result.listingId).toBe(1)
    
    const buyResult = mockBuyProduce(1, 50, 'buyer1')
    expect(buyResult.success).toBe(true)
    
    const listing = mockGetListing(1)
    expect(listing).not.toBeNull()
    expect(listing.quantity).toBe(50)
  })
})

