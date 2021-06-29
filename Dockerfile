FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app
COPY Api.csproj .
RUN dotnet restore --disable-parallel 
COPY . .
RUN dotnet build --disable-parallel --configuration Release -o /app/build


FROM build AS publish
RUN dotnet publish --disable-parallel --no-restore -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS final
WORKDIR /app
COPY --from=publish /app/out .
ENTRYPOINT ["dotnet", "Api.dll"]
