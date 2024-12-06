;; IoT Integration Contract

(define-map sensor-data
  { sensor-id: uint }
  {
    temperature: int,
    humidity: uint,
    light-level: uint,
    nutrient-level: uint,
    last-updated: uint
  }
)

(define-public (update-sensor-data (sensor-id uint) (temperature int) (humidity uint) (light-level uint) (nutrient-level uint))
  (let
    ((current-data (default-to
      { temperature: 0, humidity: u0, light-level: u0, nutrient-level: u0, last-updated: block-height }
      (map-get? sensor-data { sensor-id: sensor-id }))))
    (ok (map-set sensor-data
      { sensor-id: sensor-id }
      {
        temperature: temperature,
        humidity: humidity,
        light-level: light-level,
        nutrient-level: nutrient-level,
        last-updated: block-height
      }
    ))
  )
)

(define-read-only (get-sensor-data (sensor-id uint))
  (ok (map-get? sensor-data { sensor-id: sensor-id }))
)

(define-public (set-growing-parameters (sensor-id uint) (target-temperature int) (target-humidity uint) (target-light-level uint) (target-nutrient-level uint))
  ;; This function would interact with IoT devices to set growing parameters
  ;; For now, we'll just return OK
  (ok true)
)

