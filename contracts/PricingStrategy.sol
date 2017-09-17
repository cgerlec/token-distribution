pragma solidity ^0.4.15;


import "./SafeMathLib.sol";

<<<<<<< HEAD

library PricingStrategy
{
    using SafeMathLib for *;


    struct PricingStrategyInfo
    {
        uint multiplier; // the amount of tokens per unit of Ether
=======
library PricingStrategy
{
    struct PricingStrategyInfo
    {
        // Tiered bonuses
        uint[] tierBonusAmount;
        uint[] tierBonusReward;
        uint tierBonusCount;
    }


    /**
    * Update the pricing strategy with new parameters.
    * TODO: need to check the permissions on this
    */
    function updatePricingStrategy(PricingStrategyInfo storage self, uint[] amounts, uint[] rewards, uint count)
    {
        self.tierBonusAmount = amounts;
        self.tierBonusReward = rewards;
        self.tierBonusCount = count;
>>>>>>> d196aafe5abba181ae341abcbad1f9a722294d99
    }


    /**
<<<<<<< HEAD
     * Returns the number of tokens to be reward based on the supplied
     * pricing strategy and amount of Ether contributed.
     */
    function getTokenReward(PricingStrategyInfo storage info, uint amountInEther) returns(uint)
    {
        return amountInEther.times(info.multiplier);
    }
=======
     * Given the specified amount of tokens, this function determines the amount
     * of bonus tokens that may be awarded based on current pricing strategy.
     *
     * The pricing strategy data structure makes no guarantees that the tier-related
     * data are sorted, so this function must step through all tiers to determine
     * the maximum bonus for the specified amount of tokens.
     */
    function getTokenBonusAmount(PricingStrategyInfo storage self, uint amountInTokens) returns(uint)
    {
        uint maxBonus = 0;
        uint count = self.tierBonusCount;

        for (uint i = 0; i < count; i++)
        {
            if (amountInTokens >= self.tierBonusAmount[i])
            {
                uint bonus = self.tierBonusReward[i];
                if (maxBonus < bonus)
                {
                    maxBonus = bonus;
                }
            }
        }

        return amountInTokens * (1 + maxBonus / 100);
    }

>>>>>>> d196aafe5abba181ae341abcbad1f9a722294d99
}