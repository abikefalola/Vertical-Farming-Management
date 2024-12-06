;; Crop Management Contract

(define-map crops
  { crop-id: uint }
  {
    name: (string-ascii 64),
    farm-id: uint,
    planting-date: uint,
    expected-harvest-date: uint,
    status: (string-ascii 20)
  }
)

(define-data-var next-crop-id uint u0)

(define-public (plant-crop (name (string-ascii 64)) (farm-id uint) (expected-harvest-date uint))
  (let
    ((crop-id (+ (var-get next-crop-id) u1)))
    (map-set crops
      { crop-id: crop-id }
      {
        name: name,
        farm-id: farm-id,
        planting-date: block-height,
        expected-harvest-date: expected-harvest-date,
        status: "planted"
      }
    )
    (var-set next-crop-id crop-id)
    (ok crop-id)
  )
)

(define-public (update-crop-status (crop-id uint) (new-status (string-ascii 20)))
  (let
    ((crop (unwrap! (map-get? crops { crop-id: crop-id }) (err u404))))
    (ok (map-set crops
      { crop-id: crop-id }
      (merge crop { status: new-status })))
  )
)

(define-read-only (get-crop-info (crop-id uint))
  (ok (map-get? crops { crop-id: crop-id }))
)

