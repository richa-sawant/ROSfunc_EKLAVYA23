# ROSfunc

Using functional programming to implement a natively parallel and fault tolerant ROS-like software stack.
## Table of Contents  
- [About the Project](#about-the-project)  
- [Getting Started](#getting-started)  
    - [Prerequisites](#prerequisites)   
    - [Installation](#installation)  
- [Project Structure](#project structure)   
- [Usage](#usage)  
    -  [For independently using the PubSub Library](#for independently using the PubSub library)  
- [Acknowledgement and Resources](#acknowledgement-and-resources)  
- [Contributor ](#contributor )  
##  About The Project
This project serves as a foundational exploration of functional programming concepts. Its primary objective is to create a software system inspired by the Robot Operating System (ROS) that demonstrates a functioning publisher-subscriber communication model.

Through this project, we aim to illustrate the power and elegance of functional programming paradigms in building concurrent and distributed systems.

##  Getting Started
To get started with this project, follow these steps: 

### Prerequisites
Before you begin, ensure you have the following prerequisites:

Elixir installed on your system.
[Elixir installation instructions]( https://elixir-lang.org/install.html)

A basic understanding of functional programming concepts.

### Installation
1. Clone this repository to your local machine:
``` bash 
git clone https://github.com/richa-sawant/ROSfunc_EKLAVYA23.git
```
2. Change your working directory to the project folder:
``` bash 
cd ROSfunc_EKLAVYA23
```
3. Install project dependencies by running:
``` bash 
mix deps.get
```
4. Start the Elixir shell with:
``` bash 
iex -S mix
```
## Project Structure

`lib/`: The Elixir application source code.

`test/`: Unit tests for the application.

`mix.exs`: Project configuration file.

`README.md`: This readme file.
## Usage

This project demonstrates a simple publisher-subscriber communication model. To run the example, follow these steps:

1. Start the Elixir shell as described in the "Installation" section. 

2. In the Elixir shell, start the main module using :

` Demo.Main.start`

### For independently using the PubSub Model
1. Start the topic process.
`{:ok, topic_pid} = Demo.Pubsub.start_link()`

2. Make the subscriber subscribe to this topic using the subscriber function of the Pubsub module.
`subscribe(topic_pid, callback_fn)`
 
3. Make the Publisher publish the message onto the topic using publish function of the Pubsub module.
`publish(topic_pid, message)`
##  Acknowledgement and Resources

[Getting started guidebook](https://elixirschool.com/en/lessons/basics/basics)

[Elixir in 5 hours](https://www.youtube.com/watch?v=IiIgm_yaoOA)

[Elixir concepts](https://hexdocs.pm/elixir/1.12/Kernel.html)

[Elixir practice exercises](https://exercism.org/tracks/elixir)

Special thanks to [SRA VJTI](https://sravjti.in/) for this remarkable opportunity, also  [Viraj Shah](https://github.com/virajbshah) and [Aryan Karawale]() for mentoring me throught the project.


## Contributor 
[Richa Sawant](https://github.com/richa-sawant)
