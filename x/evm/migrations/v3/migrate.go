package v3

import (
	"github.com/Entangle-Protocol/entangle-blockchain/x/evm/types"
	sdk "github.com/cosmos/cosmos-sdk/types"
	paramtypes "github.com/cosmos/cosmos-sdk/x/params/types"
)

// MigrateStore sets the default for GrayGlacierBlock and MergeNetsplitBlock in ChainConfig parameter.
func MigrateStore(ctx sdk.Context, paramstore *paramtypes.Subspace) error {
	if !paramstore.HasKeyTable() {
		ps := paramstore.WithKeyTable(types.ParamKeyTable())
		paramstore = &ps
	}
	prevConfig := &types.ChainConfig{}
	paramstore.GetIfExists(ctx, types.ParamStoreKeyChainConfig, prevConfig)

	defaultConfig := types.DefaultChainConfig()

	prevConfig.GrayGlacierBlock = defaultConfig.GrayGlacierBlock
	prevConfig.MergeNetsplitBlock = defaultConfig.MergeNetsplitBlock

	paramstore.Set(ctx, types.ParamStoreKeyChainConfig, prevConfig)
	return nil
}
