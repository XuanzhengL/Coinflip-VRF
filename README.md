# Exercise 1 - VRF Oracle
# Part A
screen shot of RequestSent：
![image](https://github.com/user-attachments/assets/c654cffd-9f82-4b97-a5a7-8c17d8d0476b)



# Explanation of RequestSent and RequestFulfilled Events

In the Chainlink VRF process, the `RequestSent` event marks the submission of a randomness request, while the `RequestFulfilled` event indicates that the request has been successfully completed and the random numbers have been returned. The `RequestSent` event contains two fields: `requestId` and `numWords`. The `requestId` is a unique identifier generated by Chainlink VRF to track the randomness request. This identifier appears again in the `RequestFulfilled` event to ensure that the request and response are correctly matched. The `numWords` field specifies the number of random numbers requested, which is typically set to 2. This value determines the length of the `randomWords` array in the response.

Once Chainlink VRF processes the request, the `RequestFulfilled` event is triggered, containing six key fields. First, the `requestId` matches the corresponding identifier in the `RequestSent` event, ensuring that the returned random numbers are linked to the correct request. The `randomWords[0]` and `randomWords[1]` fields represent the two random numbers generated by Chainlink VRF, which are often used in probability-based applications or gaming logic. Additionally, the `payment` field records the amount of LINK tokens spent on this VRF request, ensuring the correct settlement of fees. Within the contract’s internal `s_requests` structure, there may also be `fulfilled` and `paid` fields. The `fulfilled` field is a boolean indicating whether the request has been successfully processed, while `paid` keeps track of the actual payment amount for the VRF request.

By using the `RequestSent` and `RequestFulfilled` events, we can comprehensively track the lifecycle of a Chainlink VRF randomness request, from submission to completion, ensuring accuracy and traceability of the random data.

# Part B
Related code is in the file.

# Part C

Chainlink VRF offers two main funding mechanisms: the direct funding method and the subscription method, each with distinct operational differences and suitable use cases.

The direct funding method follows a pay-per-request model, where each randomness request must be paid for individually using LINK tokens. This means that before a smart contract can request randomness, it must hold enough LINK to cover the request cost. This approach is simple and provides better control over individual transactions, making it well-suited for use cases where randomness is required infrequently, such as lotteries, single-player blockchain games, or NFT minting.

In contrast, the subscription method allows multiple contracts to share a pre-funded subscription account that pays for VRF requests. Instead of requiring LINK tokens in each contract, the user funds a subscription account in advance, from which VRF requests are automatically deducted. This method is more efficient for applications with frequent randomness requests, as it reduces transaction overhead and ensures that contracts do not run out of LINK unexpectedly. It is particularly useful for high-frequency applications such as on-chain games, decentralized finance (DeFi) platforms, and dynamic NFTs that require continuous updates.

To sum up, the direct funding method is best for single-use or low-frequency randomness needs, while the subscription method is more suited for high-frequency and multi-contract applications, offering greater efficiency and cost savings in long-term deployments.



# Exercise 2 - MakerDAO 2.0 Tokenomics
# Part A
# The State of the CDP Market and MakerDAO's Position

The Collateralized Debt Position (CDP) sector has become a cornerstone of decentralized finance (DeFi), allowing users to deposit collateral and mint stablecoins or leverage crypto holdings. MakerDAO, as the pioneer of this model, has inspired numerous competitors, each introducing unique mechanisms such as different liquidation thresholds, interest rates, and collateral compositions. 

Currently, MakerDAO remains the leading CDP platform, holding a Total Value Locked (TVL) of $15.2 billion, significantly ahead of its closest competitors, Liquity ($4.8 billion), Curve Finance’s crvUSD ($3.5 billion), Davos Protocol ($2.1 billion), and RAMP ($1.9 billion). This dominance indicates that despite emerging alternatives, MakerDAO continues to be the most trusted and capitalized protocol in the space.

Beyond TVL, MakerDAO’s DAI stablecoin remains one of the most utilized decentralized stablecoins. According to DeFiLlama, DAI consistently ranks among the top decentralized stablecoins by market capitalization, reflecting widespread adoption. Given the growing demand for yield-bearing stable assets, staking DAI across platforms such as Aave and Compound offers annual percentage yields (APYs) between 2% and 4%, making it an attractive asset for passive earnings.

Liquidation dynamics play a crucial role in the sustainability of CDP platforms. MakerDAO enforces a minimum collateralization ratio of 150%, ensuring that borrowers maintain sufficient collateral to back their DAI loans. When a Vault falls below this threshold, the system automatically initiates a liquidation auction. Participants known as Keepers bid on the collateral, often acquiring ETH at a discount, which in turn helps maintain the system’s solvency. Unlike some competitors, which rely on instant liquidations or bonding curves, MakerDAO’s auction-based liquidation model has proven resilient during market downturns, including the infamous Black Thursday event that led to significant refinements in Maker’s risk management.



![image](https://github.com/user-attachments/assets/4e094723-8f4e-46f5-9c47-8cba3459d9ab)
![image](https://github.com/user-attachments/assets/e504ca50-df4a-4df2-bb45-a9bcb396da4d)
![image](https://github.com/user-attachments/assets/29109927-79ad-4689-9004-3ad3ea27ce9d)



# Assessing MakerDAO Using DeFi Metrics

To evaluate MakerDAO’s market position, we analyze key financial and community-driven metrics. 

One of the most telling financial indicators is the Network Value to Transactions (NVT) ratio, which reflects the economic activity of a protocol relative to its market capitalization. A high NVT ratio may suggest speculative overvaluation, whereas a low ratio implies strong utility. MakerDAO's NVT ratio remains stable, indicating that its transaction volume aligns with its market cap, reinforcing its status as a well-utilized protocol rather than merely a speculative asset.

Another crucial metric is the number of unique addresses interacting with MakerDAO. Data from Dune Analytics reveals a steady increase in unique addresses, suggesting that new users continue to engage with the protocol. Additionally, Daily Active Users (DAU) metrics show consistent engagement, underscoring that MakerDAO is not only maintaining its existing user base but also attracting new participants.

Beyond user engagement, developer activity serves as a strong indicator of long-term viability. MakerDAO’s GitHub repository continues to show strong development activity, with over ten active developers making regular contributions each month. This level of ongoing development suggests that the protocol remains under continuous refinement, ensuring adaptability in the ever-evolving DeFi landscape.

Despite the rise of alternative CDP platforms, MakerDAO remains the industry leader due to its deep liquidity, robust risk management mechanisms, and a well-maintained governance structure. The protocol’s strong TVL, active user engagement, and continuous developer activity highlight its resilience and ongoing relevance in DeFi. The upcoming MakerDAO 2.0 (Sky) rebrand introduces further strategic changes that could solidify its dominance, although the broader evolution of blockchain and DeFi will ultimately determine its trajectory.

![image](https://github.com/user-attachments/assets/a584bd63-e222-4966-92a5-e07bc5f7b917)


# Part B

# Historical Price Trends and Market Evaluation

Since Black Thursday, the value of the MKR token has undergone significant fluctuations, reflecting both protocol changes and broader market conditions. In the immediate aftermath of the March 2020 market crash, MKR saw a substantial decline as the MakerDAO system struggled with undercollateralization and liquidations due to extreme volatility in Ethereum prices. However, over time, MakerDAO implemented a series of protocol changes to stabilize the ecosystem, leading to a recovery in MKR’s valuation.

A key factor in this stabilization was the introduction of new risk parameters, including improved auction mechanisms and enhancements to collateral types, ensuring greater system resilience. Additionally, MakerDAO expanded its collateral portfolio, incorporating assets beyond ETH to mitigate reliance on a single volatile asset. The implementation of real-world assets (RWAs) as collateral further contributed to Maker’s long-term stability by introducing diversified, lower-risk backing for DAI.

From the chart on CoinMarketCap, MKR reached a peak in 2021 during the broader DeFi boom, with a price exceeding $6,000 at its highest point. However, as market sentiment cooled and interest rates in traditional finance increased, MKR saw a gradual decline. In early 2025, MKR trades around $898, reflecting a more stabilized market with lower speculative interest but continued strong utility in governance and liquidation processes.

The rebranding of MakerDAO to Sky (SKY) is expected to introduce further changes to tokenomics. The transition aims to decentralize governance further and introduce new financial instruments that optimize capital efficiency. While the long-term effects remain uncertain, these innovations suggest an attempt to future-proof the protocol in a rapidly evolving DeFi landscape.

# Utility of MKR Before and After Black Thursday

| Utility            | Before Black Thursday                                | After Black Thursday                                      |
|-------------------|--------------------------------------------------|------------------------------------------------------|
| Governance       | Used for voting on risk parameters and upgrades   | Expanded to include broader protocol changes and decentralization efforts |
| Collateral Auction | Used in system failures to recapitalize DAI | Auction process improved, reducing liquidation inefficiencies |
| Stability Fee Payment | MKR used to pay accrued fees in some cases | Stability fees remain, but risk parameters are now more dynamic |
| Collateral Types | Limited to ETH and a few other assets | Expanded to include RWAs, stablecoins, and institutional-grade assets |
| Decentralization | Foundation played a central role in governance | Progress towards complete DAO governance with rebranding to Sky |

---

# Part C

MakerDAO’s transition to Sky marks a pivotal moment in its evolution. The rebranding is not merely cosmetic but reflects a shift toward further decentralization, governance restructuring, and enhanced capital efficiency. By splitting into multiple subDAOs, MakerDAO aims to create a more modular and autonomous framework, reducing centralization risks and improving decision-making efficiency.

The tokenomics of SKY is designed to distribute governance power more equitably while maintaining the core principles of MakerDAO. By introducing an ecosystem where different DAOs manage specific functions, MakerDAO is evolving into a multi-layered governance system. This change addresses prior concerns over governance bottlenecks and enhances adaptability in response to rapid market shifts.

Beyond MakerDAO itself, technological advancements such as AI and quantum computing will inevitably influence blockchain and DeFi as a whole. AI-driven risk assessment could optimize collateralization strategies, reducing systemic risks. Quantum computing, on the other hand, poses a potential security threat to cryptographic algorithms, necessitating the exploration of post-quantum security solutions within MakerDAO’s infrastructure.

Despite market fluctuations, MakerDAO’s commitment to innovation, risk management, and governance restructuring ensures its continued relevance. The success of Sky will depend on its ability to attract institutional and retail participation, maintain DAI’s stability, and integrate seamlessly with evolving financial technologies.


