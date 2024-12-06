import { describe, it, expect, beforeEach } from 'vitest'

describe('IoT Integration', () => {
  let sensorData = {}
  
  const mockUpdateSensorData = (sensorId, temperature, humidity, lightLevel, nutrientLevel) => {
    sensorData[sensorId] = { temperature, humidity, lightLevel, nutrientLevel, lastUpdated: Date.now() }
    return { success: true }
  }
  
  const mockGetSensorData = (sensorId) => {
    return sensorData[sensorId] || null
  }
  
  beforeEach(() => {
    sensorData = {}
  })
  
  it('should update and retrieve sensor data', () => {
    const sensorId = 1
    const result = mockUpdateSensorData(sensorId, 25, 60, 800, 500)
    expect(result.success).toBe(true)
    
    const data = mockGetSensorData(sensorId)
    expect(data).not.toBeNull()
    expect(data.temperature).toBe(25)
    expect(data.humidity).toBe(60)
    expect(data.lightLevel).toBe(800)
    expect(data.nutrientLevel).toBe(500)
  })
})

