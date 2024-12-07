# 5G Core Network Deployment with Free5GC and Kubernetes Using Helm

## Table of Contents (TOC)

1. [Project Overview](#project-overview)
2. [Objective](#objective)
3. [Technology Stack](#technology-stack)
4. [Installation and Setup](#installation-and-setup)
5. [Deployment Steps](#deployment-steps)
6. [Testing and Validation](#testing-and-validation)
7. [Results](#results)
8. [Contributors](#contributors)
9. [Links](#links)
10. [Future Work](#future-work)
11. [License](#license)

## Project Overview

This project demonstrates the deployment of a *5G Core Network* using *Free5GC, an open-source software suite for implementing 5G core network functions. The project is designed to showcase how cloud-native technologies such as **Kubernetes* and *Helm* can be utilized to manage and scale a 5G core network. Additionally, the project uses *UERANSIM*, a tool for simulating User Equipment (UE), to validate the successful connection and operation of the deployed 5G core network.

The objective is to deploy Free5GC's core components, simulate a UE using UERANSIM, and test the network's functionality, including subscriber management, Quality of Service (QoS), and end-to-end connectivity.

## Objective

The primary goals of this project include:

1. *Deploying the Free5GC Core Network*: Install and configure Free5GC components (like AMF, SMF, UPF) on a Kubernetes cluster.
2. *Simulating User Equipment (UE)*: Use UERANSIM to simulate UE and test the connectivity and functionality of the core network.
3. *Network Testing*: Validate the deployment by testing end-to-end communication between the simulated UE and the 5G core network using tools like ping, traceroute, and curl.
4. *WebUI Subscriber Management*: Add and manage subscribers using Free5GC’s WebUI and ensure proper configuration of network slicing, QoS, and flow control.

## Technology Stack

The following technologies were used in this project:

- *Free5GC*: An open-source 5G core network software suite that implements 5G core network functions like AMF, SMF, UPF, etc.
- *Kubernetes*: A container orchestration platform used to manage and scale the deployment of Free5GC components.
- *Helm*: A package manager for Kubernetes that simplifies the deployment and management of Kubernetes applications.
- *UERANSIM*: A tool used to simulate User Equipment (UE) and test the 5G core network deployment.
- *MicroK8s*: A lightweight version of Kubernetes, used for deploying Kubernetes clusters with minimal resource overhead.

## Installation and Setup

The setup process involves configuring the Linux machine with all the required dependencies for Free5GC and Kubernetes. The process includes:

- *Installing necessary dependencies*: This includes tools like Git, GCC, Helm, Kubernetes (via MicroK8s), and other utilities required for building and running Free5GC.
- *Setting up MicroK8s*: MicroK8s is installed to provide a lightweight Kubernetes cluster. Kubernetes is then configured with necessary add-ons such as DNS, Ingress, and Helm.
- *Installing Free5GC components*: Helm charts are used to install and configure the Free5GC components (AMF, SMF, UPF, etc.) into the Kubernetes cluster.
- *Simulating UE with UERANSIM*: UERANSIM is used to simulate a User Equipment (UE) and test the connection to the 5G core network.

## Deployment Steps

The deployment process consists of several key steps:

1. *Clone and configure dependencies*: After setting up the environment, the Free5GC and required dependencies are cloned from their respective repositories.
2. *Install MicroK8s and Helm*: MicroK8s is set up as the Kubernetes environment, and Helm is used to simplify the deployment of Free5GC's network functions.
3. *Create namespaces and persistent storage*: Kubernetes namespaces are created for isolating the Free5GC deployment, and persistent volumes are configured to ensure data persistence.
4. *Install Free5GC components*: Using Helm, various Free5GC components like AMF, SMF, and UPF are installed into the Kubernetes cluster. Each component is responsible for specific functions in the 5G core network.
5. *Deploy UERANSIM for UE simulation*: UERANSIM is deployed to simulate User Equipment, which connects to the deployed 5G core network for testing.
6. *WebUI configuration*: Subscribers are added and configured using Free5GC’s WebUI, allowing for network slicing and QoS configurations.

## Testing and Validation

After the deployment, we validated the setup by connecting a simulated User Equipment (UE) via UERANSIM to the Free5GC core network. The tests conducted include:

- *End-to-End Connectivity*: The UE was tested for connectivity with the core network using standard networking tools like ping, traceroute, and curl.
- *WebUI Subscriber Management*: A new subscriber was created using the Free5GC WebUI, and its configuration (e.g., network slicing, AMBR, etc.) was validated.
- *Network Slicing and QoS*: The configuration of network slicing and Quality of Service (QoS) was tested to ensure that the 5G core network was functioning as expected.

### Results Screenshot
![WhatsApp Image 2024-12-07 at 8 13 48 PM](https://github.com/user-attachments/assets/dda01d8f-7598-4ecd-8adb-4360ac58b74b)
![WhatsApp Image 2024-12-07 at 8 14 48 PM](https://github.com/user-attachments/assets/6d774965-da74-41fa-b623-d9ec05f9d436)
![WhatsApp Image 2024-12-07 at 8 14 37 PM](https://github.com/user-attachments/assets/6c37aa3a-80c7-40d5-a594-fec66fb650d9)
![WhatsApp Image 2024-12-07 at 8 14 15 PM](https://github.com/user-attachments/assets/c1fef4c4-b798-4879-b68b-4d3499061b75)

## Results

The deployment was successful, and the simulated User Equipment (UE) was able to connect to the Free5GC core network. The following tests were performed to validate the deployment:

1. *Ping Test*: Ensured that the UE could communicate with external addresses via the 5G core network.
2. *Traceroute Test*: Verified the routing path from the UE to an external server, ensuring that the traffic flowed correctly through the 5G core network.
3. *Curl Test*: Tested HTTP connectivity from the UE to an external server to verify the functional status of the core network.

### Key Outcomes:
- *Successful UE Connection*: The UE was able to connect to the 5G core network and communicate with external servers.
- *Network Slicing Configurations*: The network slicing and QoS configurations were successfully tested and validated using the WebUI.

## Contributors

- *Deepak Gohil* - 202152311
- *Aayush Patel* - 202151106
- *Devarsh Patel* - 202151107
- *Sarthak Tailor* - 202151169

## Links

- [Video Demonstration of the Project](https://drive.google.com/drive/folders/1c_cY7-tSvcCpJR9M_BcwZWQ-NwnEl1Jl?usp=sharing)
- [Project Report (PDF)](https://drive.google.com/file/d/1NFmwaRCZ9g1oCPuQtBEzpsAptlweJ65E/view?usp=sharing)

## Future Work

In the future, the project could be expanded in several ways:

- *Scalability Testing*: Deploying the solution in a multi-node Kubernetes cluster to test scalability.
- *Integration with Real Devices*: Testing the deployment with real 5G-enabled devices to ensure that it functions in a production-like environment.
- *Advanced Security Features*: Incorporating advanced security measures such as encryption and authentication enhancements.
- *Enhanced Network Slicing*: Further exploring network slicing features to optimize traffic for different types of services (e.g., eMBB, URLLC, mMTC).

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/IIITV-5G-and-Edge-Computing-Activity/free5gc-5G-core-kubernetes-deployment/blob/main/LICENSE) file for details.
