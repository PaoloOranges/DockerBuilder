# DockerBuilder
Collection of Dockerfile and utilities for creating containers to run Quantconnect Lean Engine and tools.

## DownloadDataUntilNow.sh
Bash script for calling **QuantConnect.GDAXBrokerage.ToolBox** to download tickers based on *tickers* file.
Params are:
- **-p** : Download Path. Absoluth PATH where **QuantConnect.GDAXBrokerage.ToolBox.dll** is. If not set, current directory is considered.
. **-t** : path and filename where tickers are. If not defined, **tickers** in current directory is used.

## config.json

Basic configuration for **QuantConnect.GDAXBrokerage.ToolBox** as per Lean configuration format.

## DockerfileToolboxCoinbasePro

Dockerfile to build image with the downloader. Must be called from a directory that contains Lean Engine code, Lean.Brokerage.CoinbasePro code.

## tickers
list of tickers to download
