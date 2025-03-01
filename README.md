# SeedSwap: P2P Gardening Exchange Protocol

A decentralized platform for gardeners to exchange seeds, plants, and gardening knowledge.

## Overview

SeedSwap is a blockchain-based protocol that enables peer-to-peer exchange of seeds and plants among gardening enthusiasts. Built on Stacks blockchain using Clarity smart contracts, it provides a secure and transparent way for gardeners to share their excess seeds and find new varieties to grow.

## Features

- Create offerings for seeds you want to share
- Browse available seed offerings by type and growing zone
- Direct peer-to-peer exchanges without intermediaries
- Transparent history of seed origins and exchanges
- Community rating system for seed quality and grower reputation

## Smart Contract Functions

### Core Functions

- `create-offering`: List new seeds to share with the community
- `withdraw-offering`: Remove your seed listing from the available pool
- `get-offering`: View details about a specific seed offering
- `get-grower`: Find information about who is offering specific seeds

### Error Codes

- `ERR-NOT-AUTHORIZED (u1)`: User not authorized for this action
- `ERR-OFFERING-NOT-FOUND (u2)`: The specified seed offering doesn't exist
- `ERR-ALREADY-OFFERED (u3)`: This seed offering is already listed
- `ERR-INVALID-STATUS (u4)`: Invalid status for this operation
- `ERR-INVALID-QUANTITY (u5)`: Quantity must be greater than minimum
- `ERR-INVALID-GROWTH-ZONE (u6)`: Unrecognized growing zone
- `ERR-INVALID-TYPE (u7)`: Unrecognized seed type
- `ERR-INVALID-NAME (u8)`: Name must be between 3-50 characters
- `ERR-INVALID-DESCRIPTION (u9)`: Description must be between 10-200 characters

## Data Structures

Seed offerings include the following information:

- Grower's principal address
- Seed name
- Description
- USDA growth zone compatibility
- Seed type (vegetables, fruits, flowers, herbs, trees)
- Status (available, withdrawn)
- Quantity available

## Getting Started

1. Clone this repository
2. Install Clarinet for local development
3. Run tests to ensure functionality
4. Deploy to testnet for community testing
