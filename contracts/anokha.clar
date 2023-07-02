;; Anokha-contract

;; Here we're just implementing the tait, mean that we have to implement all the functions defined in the trait.
(impl-trait 'SP2PABAF9FTAJYNFZH93XENAJ8FVY99RRM50D2JG9.nft-trait.nft-trait )

;; Here we're define a new nft class 'anokha' which points to uint, kind of tokenId in solidity.
(define-non-fungible-token anokha uint)

;; Here we' define a new variable which keeps track of number of nfts minted.
(define-data-var token-id uint u0)

;; Here we're just define a new constant, the owner or creator of the contract usinf 'tx-sender' same 'msg.sender' in solidity.
(define-constant contract-owner tx-sender)

;; here the mapping comes.

;; It defines a particular mapping which maps a uint (tokenid) to details of listings.
(define-map listings uint {
        seller: principal,
        price: uint,
        active: bool
    })

;; It defines a particular mapping which maps a tokenid to ascii string.
(define-map token-uri uint (string-ascii 46))


  (define-public (mint-list (recipient principal) (uri (string-ascii 46)) (token_price uint))
	(let
		(
			(new-token-id (+ (var-get token-id) u1))
		)
		(try! (nft-mint? anokha new-token-id recipient))
        (map-set listings new-token-id {seller: recipient, price: token_price, active: true})
        (map-set token-uri new-token-id uri)
		(var-set token-id new-token-id)
		(ok new-token-id)
	)
)

(define-public (mint (recipient principal) (uri (string-ascii 46)) (token_price uint))
	(let
		(
			(new-token-id (+ (var-get token-id) u1))
		)
		(try! (nft-mint? anokha new-token-id recipient))
        (map-set token-uri new-token-id uri)
		(var-set token-id new-token-id)
		(ok new-token-id)
	)
)

;; As the clarity doesnot support loops, we will use our backend to store the nfts of a particular user.

;; to be implemented: buy-nft & cancel-listing.
