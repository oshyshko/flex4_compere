package util {

import mx.core.UIComponent;
import mx.events.FlexEvent;

public class Compere {
    private var container:UIComponent;
    private var current:UIComponent

    public function Compere(container:UIComponent, current:UIComponent) {
        this.container = container;
        this.current = current
    }

    public function show(toCurrent:UIComponent):void {
        if (container.currentState == toCurrent.id) return

        // TODO will creation of this anon-function produce a memory leak?
        const onHidden:Function = function (e:FlexEvent):void {
            current.removeEventListener(FlexEvent.STATE_CHANGE_COMPLETE, onHidden)
            toCurrent.currentState = 'hidden'
            container.currentState = toCurrent.id

            container.callLater(function ():void {
                toCurrent.currentState = 'normal'
                current = toCurrent
            })
        }

        current.addEventListener(FlexEvent.STATE_CHANGE_COMPLETE, onHidden)
        current.currentState = 'hidden'
    }

}
}
