;; Produce Marketplace Contract

(define-map produce-listings
  { listing-id: uint }
  {
    farm-id: uint,
    crop-id: uint,
    quantity: uint,
    price: uint,
    seller: principal
  }
)

(define-data-var next-listing-id uint u0)

(define-public (create-listing (farm-id uint) (crop-id uint) (quantity uint) (price uint))
  (let
    ((listing-id (+ (var-get next-listing-id) u1)))
    (map-set produce-listings
      { listing-id: listing-id }
      {
        farm-id: farm-id,
        crop-id: crop-id,
        quantity: quantity,
        price: price,
        seller: tx-sender
      }
    )
    (var-set next-listing-id listing-id)
    (ok listing-id)
  )
)

(define-public (buy-produce (listing-id uint) (quantity uint))
  (let
    ((listing (unwrap! (map-get? produce-listings { listing-id: listing-id }) (err u404))))
    (asserts! (<= quantity (get quantity listing)) (err u400))
    (try! (stx-transfer? (* quantity (get price listing)) tx-sender (get seller listing)))
    (if (< quantity (get quantity listing))
      (map-set produce-listings
        { listing-id: listing-id }
        (merge listing { quantity: (- (get quantity listing) quantity) }))
      (map-delete produce-listings { listing-id: listing-id })
    )
    (ok true)
  )
)

(define-read-only (get-listing (listing-id uint))
  (ok (map-get? produce-listings { listing-id: listing-id }))
)

