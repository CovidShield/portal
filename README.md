# COVID Shield Web Portal

![Master Dockerhub container build status](https://github.com/CovidShield/portal/workflows/Dockerhub%20Container%20Builds/badge.svg)
![Master Terraform status](https://github.com/CovidShield/portal/workflows/Terraform/badge.svg)
![Master tests status](https://github.com/CovidShield/portal/workflows/Tests/badge.svg)

This web-based results portal is accessible only by healthcare professionals and can be deployed federally, provincially, or municipally. It provides unique temporary codes to healthcare professionals who then give those codes to users of the mobile app. This code gives the app access to upload their anonymized device identifiers. There is no association between these temporary codes and specific tests or individuals. The code is delivered over the phone so it cannot be traced to any individual or their test results.

For more information on how this all works, read through the [COVID Shield Rationale](https://github.com/CovidShield/rationale).

## Role (optional)

The use of this portal is optional and you can easily integrate the code creation system into any existing system that your public health officials have access to. After you have deployed the backend, you can generate keys with [simple API calls](https://github.com/CovidShield/backend/tree/master/examples/new-key-claim).

## User Experience

- [Design files on Figma](https://www.figma.com/file/b76OYDhkTKJCaqDfVQybQY/Open-Source-COVID-Shield?node-id=68%3A167)
- [Glossary of terms](https://github.com/CovidShield/rationale/blob/master/GLOSSARY.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Who built COVID Shield?

We are a group of Shopify volunteers who want to help to slow the spread of COVID-19 by offering our
skills and experience developing scalable, easy to use applications. We are releasing COVID Shield
free of charge and with a flexible open-source license.

For questions, we can be reached at <press@covidshield.app>.
