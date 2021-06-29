FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app
COPY Api.csproj .
RUN sudo dotnet restore
COPY . ./
RUN sudo dotnet build "Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN sudo dotnet publish --no-restore -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS final
WORKDIR /app
COPY --from=publish /app/out .
ENTRYPOINT ["sudo", "dotnet", "Api.dll"]
