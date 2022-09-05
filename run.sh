#!/usr/bin/env bash

if [ $# -ne 2 ]; then
    echo "Invalid arguments"
    exit 1
fi

case $1 in

call-me)
    script="CallMeSolution"
    ;;

nickname)
    script="NicknameSolution"
    ;;

guess-the-number)
    script="GuessTheNumberSolution"
    ;;

guess-the-secret-number)
    script="GuessTheSecretNumberSolution"
    ;;

guess-the-random-number)
    script="GuessTheRandomNumberSolution"
    ;;

guess-the-new-number)
    script="GuessTheNewNumberSolution"
    ;;

predict-the-future)
    script="PredictTheFutureSolution"
    ;;

predict-the-block-hash)
    script="PredictTheBlockHashSolution"
    ;;

token-sale)
    script="TokenSaleSolution"
    ;;

token-whale)
    script="TokenWhaleSolution"
    ;;

retirement-fund)
    script="RetirementFundSolution"
    ;;

mapping)
    script="MappingSolution"
    ;;

donation)
    script="DonationSolution"
    ;;

fifty-years)
    script="FiftyYearsSolution"
    ;;

assume-ownership)
    script="AssumeOwnershipSolution"
    ;;

token-bank)
    script="TokenBankSolution"
    ;;

*)
    echo "Invalid challenge name"
    exit 1
    ;;
esac

if [[ $2 =~ ^(0x)?[0-9a-fA-F]{40}$ ]]; then
    export ADDRESS=$2
else
    echo "Invalid challenge address"
    exit 1
fi

source .env

echo Running exploit: $script...

forge script $script \
    --rpc-url $RPC_URL \
    --private-key $PLAYER_KEY \
    --broadcast \
    -vvvv
