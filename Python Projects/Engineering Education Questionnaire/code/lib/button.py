class button:
    def disableSubmitButton(self):
        gui.submitButton.config(state='disabled')

    def enableSubmitButton(self):
        gui.submitButton.config(state='active')