;; Resource Allocation Contract

(define-map resource-allocations
  { farm-id: uint }
  {
    water: uint,
    electricity: uint,
    nutrients: uint
  }
)

(define-public (allocate-resources (farm-id uint) (water uint) (electricity uint) (nutrients uint))
  (ok (map-set resource-allocations
    { farm-id: farm-id }
    {
      water: water,
      electricity: electricity,
      nutrients: nutrients
    }
  ))
)

(define-read-only (get-resource-allocation (farm-id uint))
  (ok (map-get? resource-allocations { farm-id: farm-id }))
)

(define-public (update-resource-allocation (farm-id uint) (resource-type (string-ascii 20)) (amount uint))
  (let
    ((current-allocation (unwrap! (map-get? resource-allocations { farm-id: farm-id }) (err u404))))
    (if (is-eq resource-type "water")
      (ok (map-set resource-allocations
        { farm-id: farm-id }
        (merge current-allocation { water: amount })))
      (if (is-eq resource-type "electricity")
        (ok (map-set resource-allocations
          { farm-id: farm-id }
          (merge current-allocation { electricity: amount })))
        (if (is-eq resource-type "nutrients")
          (ok (map-set resource-allocations
            { farm-id: farm-id }
            (merge current-allocation { nutrients: amount })))
          (err u400) ;; Invalid resource type
        )
      )
    )
  )
)

