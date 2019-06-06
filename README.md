
#  The MVVM Design Pattern

## This repository includes an implementation of the ideas presented in Paul Hudson's Swift Design Patterns (2019 - Swift 5, iOS 12)

It demonstrates common patterns to implement MVVM binding:

1. Through an Observable wrapper around a model, mixed with callback firing.

2. KVO, which is syntactically uglier and less "Swifty", but can get the job done with a bit more code.

3. Not covered in this implementation, using a React framework such as [Bond](https://github.com/DeclarativeHub/Bond), [RxSwift](https://github.com/ReactiveX/RxSwift), or Apple's shiny new [Combine](https://developer.apple.com/documentation/combine).

As a extra, I wanted to do MVVM right. The example used in the book doesn't actually include a view model. Its main purpose is really to demonstrate binding, but I wanted to use an actual view model to wrap the model in.

The creation of the view model can be determined by changing an enumeration value in the app delegate, for the sake of this exercise.

ViewController accepts two different view models. One implements binding using KVO and the other implements binding through an Observable object wrapper, to demonstrate how binding can occur in different ways.

## Thoughts Regarding MVVM Implementation

> “The goal is that your view model should wrap your model entirely – **the view layer should have no concept of the model existing.** When building your view model, remember one of the big wins is to make it testable without involvement from UIKit or AppKit: your view controller should take your UITextField (or UISwitch, UIButton, etc) and **send its value into the view model rather than the object itself**.” - Excerpt From: Paul Hudson. “Swift Design Patterns.” Apple Books. 

Under this goal, any implementation of MVVM where the model is not private to the view model wouldn't be fully adhering to MVVM principles, because then the view layer would have a concept of the model existing.

It would seem that the very nature of binding a view element to a model property breaks the idea of MVVM.

Using the Observable wrapper example in the book, The BoundTextField, a *view*, ignores this model encapsulation principle of MVVM, as it has direct access to the getter and setter of its view model's model and is bound to it directly, rather than this interaction being fed through the view model itself. 

However, most implementations of MVVM do seem to ignore this principle as well, choosing to bind views to models directly. Frameworks such as RxSwift and Bond and just about every tutorial demonstrate that pretty clearly.

There seem to be two distinct ideas of what MVVM is:

1. [**"Separated"**](https://i0.wp.com/techtales.co/wp-content/uploads/2017/08/MVVM.png?fit=770%2C230) MVVM, where the view and model have no knowledge of each other. I've yet to run across a code implementation of this in Swift, yet most diagrams of MVVM demonstrate this.

2. [**"Bound"**](https://i.imgur.com/Flq90tQ.png) MVVM,
    For convenience, views are bound to a property on the view model's model via KVO, an Observable wrapper, or a library that gives binding capabilities and takes away the boilerplate. Every implementation of MVVM I've run across in Swift follows this pattern to some degree. 
    
    Microsoft acknowledges this style of MVVM as well
    
    > "The view model might choose to expose model classes directly to the view so that controls in the view can data bind directly to them" -https://docs.microsoft.com/en-us/xamarin/xamarin-forms/enterprise-application-patterns/mvvm

By the end of this tutorial, it's not really clear what function a view model has in the "Bound" MVVM architecture.

Some ideas for its use are presented, which fall in line with my usage of MVVM and most example implementations I've seen.

> “In a real app your view model would include formatting of values (for example converting a Date into a string ready for display), archiving and unarchiving of data, and perhaps even networking code.” - Excerpt From: Paul Hudson. “Swift Design Patterns.” Apple Books. 

However, it does feel there's no concrete definition of what a view model's responsibility should be, other than being a miscellaneous dumping ground of non-view responsibility:

> “[...] similar to MVC I think it’s fair to say that MVVM separates responsibilities reasonably well enough that beginners can understand it: models store data, views store visual representations of data, and **everything else goes into the view model**. At least with MVVM putting “everything else” into the view model feels dubious, so developers might be inspired to split it off." -Excerpt From: Paul Hudson. “Swift Design Patterns.” Apple Books. 

> ""The viewmodel is a key piece of the triad because it introduces **Presentation Separation**, or the concept of keeping the nuances of the view separate from the model. Instead of making the model aware of the user’s view of a date, so that it converts the date to the display format, the model simply holds the data, the view simply holds the formatted date, and the controller acts as the liaison between the two. The controller might take input from the view and place it on the model, or it might interact with a service to retrieve the model, then translate properties and place it on the view." - [CodeProject.com](https://www.codeproject.com/Articles/100175/Model-View-ViewModel-MVVM-Explained)

> "View models transform model information into values that can be displayed on a view" - ["Ray Wenderlich"](https://www.raywenderlich.com/34-design-patterns-by-tutorials-mvvm)

In essence, the view model is really just a presenter that also accepts general business logic responsibilities. It's tasked with translating model information into a format easily displayable by the view. Though, under this loose definition, it can be tasked with really anything that doesn't have to do with the view or its controller. It's almost a helper object of sorts to take on any heavy lifting.

> "[...], it frees up the view controller to do what it was meant to do: focus on view lifecycle events. Yes, you might just have transferred 80% of your code [*somewhere else*](https://imgflip.com/i/32i0mk), and that “somewhere else” might end up being just as much of a dumping ground as your view controller was, but it’s an improvement.” - Excerpt From: Paul Hudson. “Swift Design Patterns.” Apple Books. 

It makes sense that any business logic should not live in the view controller, however, it feels like MVVM is just one part of a step to a fleshed out pattern where everything has a place, though [such a pattern could in some cases just create more encumbrance in some projects](https://www.objc.io/issues/13-architecture/viper/). Ultimately, I would agree with the sentiment that MVVM is generally a step up from MVC, and serves well to remind us as developers to have more consideration of [Separation of Concerns](https://en.wikipedia.org/wiki/Separation_of_concerns).
