import { describe, it, expect, beforeEach } from 'vitest'

describe('Crop Management', () => {
  let crops = {}
  let nextCropId = 1
  
  const mockPlantCrop = (name, farmId, expectedHarvestDate) => {
    const cropId = nextCropId++
    crops[cropId] = { name, farmId, plantingDate: Date.now(), expectedHarvestDate, status: 'planted' }
    return { success: true, cropId }
  }
  
  const mockUpdateCropStatus = (cropId, newStatus) => {
    if (crops[cropId]) {
      crops[cropId].status = newStatus
      return { success: true }
    }
    return { success: false, error: 'Crop not found' }
  }
  
  const mockGetCropInfo = (cropId) => {
    return crops[cropId] || null
  }
  
  beforeEach(() => {
    crops = {}
    nextCropId = 1
  })
  
  it('should plant and manage crops', () => {
    const result = mockPlantCrop('Lettuce', 1, Date.now() + 30 * 24 * 60 * 60 * 1000)
    expect(result.success).toBe(true)
    expect(result.cropId).toBe(1)
    
    const updateResult = mockUpdateCropStatus(1, 'growing')
    expect(updateResult.success).toBe(true)
    
    const cropInfo = mockGetCropInfo(1)
    expect(cropInfo).not.toBeNull()
    expect(cropInfo.name).toBe('Lettuce')
    expect(cropInfo.status).toBe('growing')
  })
})

