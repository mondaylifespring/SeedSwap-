;; SeedSwap: P2P Gardening Exchange Protocol
;; Version: 1.0.0

(define-constant ERR-NOT-AUTHORIZED (err u1))
(define-constant ERR-OFFERING-NOT-FOUND (err u2))
(define-constant ERR-ALREADY-OFFERED (err u3))
(define-constant ERR-INVALID-STATUS (err u4))
(define-constant ERR-INVALID-QUANTITY (err u5))
(define-constant ERR-INVALID-GROWTH-ZONE (err u6))
(define-constant ERR-INVALID-TYPE (err u7))
(define-constant ERR-INVALID-NAME (err u8))
(define-constant ERR-INVALID-DESCRIPTION (err u9))

(define-constant MIN-QUANTITY u1)

(define-data-var next-offering-id uint u1)

(define-map offerings
    uint
    {
        grower: principal,
        seed-name: (string-utf8 50),
        description: (string-utf8 200),
        growth-zone: (string-utf8 10),
        seed-type: (string-utf8 20),
        status: (string-utf8 10),
        quantity: uint
    }
)

(define-private (validate-growth-zone (zone (string-utf8 10)))
    (or 
        (is-eq zone u"Zone 1-3")
        (is-eq zone u"Zone 4-6")
        (is-eq zone u"Zone 7-8")
        (is-eq zone u"Zone 9-10")
        (is-eq zone u"Zone 11+")
        (is-eq zone u"Indoor")
    )
)

(define-private (validate-seed-type (type (string-utf8 20)))
    (or 
        (is-eq type u"Vegetables")
        (is-eq type u"Fruits")
        (is-eq type u"Flowers")
        (is-eq type u"Herbs")
        (is-eq type u"Trees")
    )
)

(define-private (validate-text-length (text (string-utf8 200)) (min-length uint) (max-length uint))
    (let 
        (
            (text-length (len text))
        )
        (and 
            (>= text-length min-length)
            (<= text-length max-length)
        )
    )
)

(define-public (create-offering 
    (seed-name (string-utf8 50))
    (description (string-utf8 200))
    (growth-zone (string-utf8 10))
    (seed-type (string-utf8 20))
    (quantity uint)
)
    (let
        (
            (offering-id (var-get next-offering-id))
        )
        (asserts! (validate-text-length seed-name u3 u50) ERR-INVALID-NAME)
        (asserts! (validate-text-length description u10 u200) ERR-INVALID-DESCRIPTION)
        (asserts! (>= quantity MIN-QUANTITY) ERR-INVALID-QUANTITY)
        (asserts! (validate-growth-zone growth-zone) ERR-INVALID-GROWTH-ZONE)
        (asserts! (validate-seed-type seed-type) ERR-INVALID-TYPE)
        
        (map-set offerings offering-id {
            grower: tx-sender,
            seed-name: seed-name,
            description: description,
            growth-zone: growth-zone,
            seed-type: seed-type,
            status: u"available",
            quantity: quantity
        })
        (var-set next-offering-id (+ offering-id u1))
        (ok offering-id)
    )
)

(define-public (withdraw-offering (offering-id uint))
    (let
        (
            (offering (unwrap! (map-get? offerings offering-id) ERR-OFFERING-NOT-FOUND))
        )
        (asserts! (is-eq tx-sender (get grower offering)) ERR-NOT-AUTHORIZED)
        (asserts! (is-eq (get status offering) u"available") ERR-INVALID-STATUS)
        (ok (map-set offerings offering-id (merge offering { status: u"withdrawn" })))
    )
)

(define-read-only (get-offering (offering-id uint))
    (ok (map-get? offerings offering-id))
)

(define-read-only (get-grower (offering-id uint))
    (ok (get grower (unwrap! (map-get? offerings offering-id) ERR-OFFERING-NOT-FOUND)))
)