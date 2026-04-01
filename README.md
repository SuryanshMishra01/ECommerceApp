//
//  REAME.md
//  ECommerce
//
//  Created by Suryansh Mishra on 01/04/26.
//

# ECommerce Application

This is a sample ECommerce application, native to MacOS platform, using Swift & SwiftUI.

## Table of Contents

*   Home
*   Products
*   Cart
*   Checkout

### Authentication

These frameworks are used for authentication:
                                    
*   FirebaseAuth
*   FirebaseCore
                                
### Lazy Loading & Caching
     
This is achieved using:

*   NukeUI
*   Nuke

                                ## Issues during Code Signing & Notarization

                                *   Frameworks are statically linked with app binary, so there is no need to code sign them seperately.
                                *   Only sign the main .app bundle with entitlements flag
                                *   There must be a .entitlements file in main app target and it must include:
                                      1) Disable Library Validation - Yes
                                      2) Allow Execution of JIT-compiled code - Yes
                                      3) Allow Unsigned Executable Memory - Yes
                                      4) It must have a Keychain Access Group - This is required internally by FirebaseAuth.
