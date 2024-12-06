import { describe, it, expect, beforeEach } from 'vitest'

describe('Resource Allocation', () => {
  let resourceAllocations = {}
  
  const mockAllocateResources = (farmId, water, electricity, nutrients) => {
    resourceAllocations[farmId] = { water, electricity, nutrients }
    return { success: true }
  }
  
  const mockGetResourceAllocation = (farmId) => {
    return resourceAllocations[farmId] || null
  }
  
  beforeEach(() => {
    resourceAllocations = {}
  })
  
  it('should allocate and retrieve resources', () => {
    const farmId = 1
    const result = mockAllocateResources(farmId, 1000, 500, 200)
    expect(result.success).toBe(true)
    
    const allocation = mockGetResourceAllocation(farmId)
    expect(allocation).not.toBeNull()
    expect(allocation.water).toBe(1000)
    expect(allocation.electricity).toBe(500)
    expect(allocation.nutrients).toBe(200)
  })
})

