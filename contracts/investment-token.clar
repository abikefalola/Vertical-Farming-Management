;; Investment Token Contract

(define-fungible-token farm-token)

(define-map farm-investments
  { farm-id: uint }
  { total-investment: uint }
)

(define-map investor-shares
  { farm-id: uint, investor: principal }
  { shares: uint }
)

(define-public (invest (farm-id uint) (amount uint))
  (let
    ((current-investment (default-to { total-investment: u0 } (map-get? farm-investments { farm-id: farm-id })))
     (current-shares (default-to { shares: u0 } (map-get? investor-shares { farm-id: farm-id, investor: tx-sender }))))
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
    (try! (ft-mint? farm-token amount tx-sender))
    (map-set farm-investments
      { farm-id: farm-id }
      { total-investment: (+ (get total-investment current-investment) amount) })
    (map-set investor-shares
      { farm-id: farm-id, investor: tx-sender }
      { shares: (+ (get shares current-shares) amount) })
    (ok true)
  )
)

(define-public (distribute-profits (farm-id uint) (total-profit uint))
  (let
    ((farm-investment (unwrap! (map-get? farm-investments { farm-id: farm-id }) (err u404))))
    (ok (map-delete farm-investments { farm-id: farm-id }))
  )
)

(define-read-only (get-investment-share (farm-id uint) (investor principal))
  (ok (map-get? investor-shares { farm-id: farm-id, investor: investor }))
)

