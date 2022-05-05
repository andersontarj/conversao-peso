FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
LABEL MAINTAINER = "Anderson Amaral - KubDev/DevOps Pro"
WORKDIR /app
EXPOSE 5000

ENV ASPNETCORE_URLS=http://+:5000

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY *.sln ./
COPY ConversaoPeso.Web/ConversaoPeso.Web.csproj ConversaoPeso.Web/
RUN dotnet restore
COPY . .
WORKDIR /src/ConversaoPeso.Web
RUN dotnet build ConversaoPeso.Web.csproj -c Release -o /app/build

FROM build AS publish
RUN dotnet publish ConversaoPeso.Web.csproj -c Release -o /app/publish /p:UseAppHost=true

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ConversaoPeso.Web.dll"]