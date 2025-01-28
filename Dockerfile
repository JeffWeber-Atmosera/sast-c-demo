# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /sources

# copy everything else and build app
COPY WebGoat.NET/. ./WebGoat.NET/
WORKDIR /sources/WebGoat.NET
RUN dotnet publish WebGoat.NET.csproj -c Release -o /app

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app ./

ENTRYPOINT ["dotnet", "WebGoat.NET.dll"] 
