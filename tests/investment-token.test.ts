import { describe, it, expect, beforeEach } from 'vitest'

describe('Investment Token', () => {
  let farmInvestments = {}
  let investorShares = {}
  
  const mockInvest = (farmId, amount, investor) => {
    farmInvestments[farmId] = (farmInvestments[farmId] || 0) + amount
    investorShares[`${farmId}-${investor}`] = (investorShares[`${farmId}-${investor}`] || 0) + amount
    return { success: true }
  }
  
  const mockGetInvestmentShare = (farmId, investor) => {
    return { shares: investorShares[`${farmId}-${investor}`] || 0 }
  }
  
  beforeEach(() => {
    farmInvestments = {}
    investorShares = {}
  })
  
  it('should handle investments and shares', () => {
    const result = mockInvest(1, 1000, 'investor1')
    expect(result.success).toBe(true)
    
    const shares = mockGetInvestmentShare(1, 'investor1')
    expect(shares.shares).toBe(1000)
    
    mockInvest(1, 500, 'investor2')
    expect(farmInvestments[1]).toBe(1500)
  })
})

